fileName = 'E:\zy\�����п�Ժ\banmayu\banmayu20150709002.tif';
% ͼ����Ϣ
info = imfinfo(fileName);
% ͼ������
imNum = numel(info);

for i=1:imNum
    %��һ��ͼ
    im = imread(fileName, i);
    handle = imshow(im, []);
    pause(0.5);
%     delete(handle);
end