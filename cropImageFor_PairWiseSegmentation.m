% crop a small rectangle region from a huge one


% Set data base dir
baseDir = 'E:\zy\医疗大数据\广州中科院数据\SegmentationDataSet\';

% assume data in dir 'original', and mask in dir 'mask_output'
fileDataDir = [baseDir, 'original\'];
fileLabelDir = [baseDir, 'mask_output\'];

filesData = dir(fullfile(fileDataDir, '*.TIF'));

filesLabel = dir(fullfile(fileLabelDir, '*.tif'));

% output dir for data and label
saveDataDir = './data/';
saveLabelDir = './label/';

fileNum = length(filesData);

beginFrameNum = 1;
endFrameNum = fileNum;

for i=beginFrameNum:endFrameNum
    filenameData = filesData(i).name;
    filenameLabel = filesLabel(i).name;
   
    imData = imread(strcat(fileDataDir, filenameData));
    imLabel = imread(strcat(fileLabelDir, filenameLabel));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%  Crop Begin  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cropFinished = false;
    %%%%%%%%%%%%%%%%%%%% Wait for mouse click
    while ~cropFinished
        imshow(imLabel);
        title(filenameLabel);
        w = waitforbuttonpress;            % wait mouse clicked
        if w==0    % return 0 means mouse click
            point = get(gca,'CurrentPoint');    % button down detected
            point = point(1,1:2);       % get the left top point axis
            windowSize = 480;
            choosedRect = [point(1), point(2), windowSize-1, windowSize-1];
            rectangle('Position', choosedRect, 'EdgeColor', 'g');
            
            %%%%%%%%%%%%%%%%%%%% Wait for key confirm
            w = waitforbuttonpress;
            if w==1    % return 1 means key press
                a = get(gcf,'CurrentCharacter');
                if a=='s'
                    cropedLabel = imcrop(imLabel, choosedRect);    % manual crop end frame
                    cropedData = imcrop(imData, choosedRect);
                    imwrite(cropedLabel, [saveLabelDir, filenameLabel]);
                    imwrite(cropedData, [saveDataDir,filenameData ]);
                    cropFinished = true;
                end
            end
            
        end 
    end
    
    fprintf('croping %i\n', i);
end

