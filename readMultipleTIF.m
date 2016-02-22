fileName = 'E:\zy\广州中科院\banmayu\banmayu20150709002.tif';
% 图像信息
info = imfinfo(fileName);
% 图像数量
imNum = numel(info);

for i=1:imNum
    %读一张图
    im = imread(fileName, i);
    handle = imshow(im, []);
    pause(0.5);
%     delete(handle);
end