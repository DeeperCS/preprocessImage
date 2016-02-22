% fileName = 'I:\广州中科院数据\osk-8000-B-new\osk-8000-B-new_t299c2.TIF';
% 
% im = imread(fileName);

% imResized = imresize(im, 0.5);
% 
% imwrite(imResized, 'e:\test.tif');

% fileDir = 'E:\zy\医疗大数据\广州中科院数据\banmayu\1\';
fileDir = 'D:\3rdData\v4_osk_3d-b\c1\';
files = dir(fullfile(fileDir, '*.tif'));

fileNum = length(files);

scale = 0.25;
for i=1:fileNum
    im = imread(strcat(fileDir, files(i).name));
    imResized = imresize(im, scale);
    imwrite(imResized, strcat('D:\3rdData\v4_osk_3d-b\c1Resized\', files(i).name));
    fprintf('resizing %i\n', i);
end

