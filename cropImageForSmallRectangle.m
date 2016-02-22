% crop a small rectangle region from a huge one


% Set data base dir
baseDir = 'E:\zy\医疗大数据\广州中科院数据\osk-8000-B-new\C1\';

filesData = dir(fullfile(baseDir, '*.TIF'));

% output dir for data and label
saveDataDir = './data/';

fileNum = length(filesData);

beginFrameNum = 90;
endFrameNum = 10;

choosedRect = [];
cropFinished = false;

for i=beginFrameNum:endFrameNum
    filenameData = filesData(i).name;
   
    imData = imread(strcat(baseDir, filenameData));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%  Crop Begin  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%% Wait for mouse click
    while ~cropFinished
        imshow(imData);
        title(filenameData);
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
                    cropedData = imcrop(imData, choosedRect);
                    imwrite(cropedData, [saveDataDir,filenameData ]);
                    cropFinished = true;
                end
            end
            
        end 
    end
    
    if cropFinished
        cropedData = imcrop(imData, choosedRect);
        imwrite(cropedData, [saveDataDir,filenameData ]);
    end
    
    fprintf('croping %i\n', i);
end

