clc;close all;clear;

% Read image
pic = imread('m610110011_hw2_pic.jpg');
pic_gray = rgb2gray(pic);

figure, imshow(pic_gray);
title('Original')
% imwrite(pic_gray, 'gray.png')

%% Histogram stretching using IMADJUST
cellImadj = imadjust(pic_gray);

% adjust With parameter
adjustHistOutput=imadjust(pic_gray,[20 200]/255,[]);

figure, imshow(adjustHistOutput);
title('Image after IMADJUST [20 200]');
% imwrite(adjustHistOutput, 'adjustHistOutput.png')

%% HISTEQ performs histogram equalization. It enhances the contrast of 
HistEq = histeq(pic_gray);
figure, imshow(HistEq)
title('Histogram Equalized Image')
% imwrite(HistEq, 'HistEq.png')

%% Examine histogram of the original and equalized image

% original image histogram
figure 
subplot(1,2,1), imhist(pic_gray); 
axis tight; 
title('Original histogram');

% Compare histograms of the original image  and contrast adjusted image
subplot(1,2,2),  imhist(HistEq); axis tight;
title('Equalized histogram');

%% ADAPTHISTEQ performs contrast-limited adaptive histogram equalization. 
AdaptHist = adapthisteq(pic_gray,'NumTiles',[12,12]);
figure, imshow(AdaptHist)
title('Adaptive Histogram Equalization')
imwrite(AdaptHist, 'AdaptHist.png')

figure 
subplot(1,2,1), imhist(pic_gray); 
axis tight; 
title('Original histogram');

% Compare histograms of the original image  and contrast adjusted image
subplot(1,2,2),  imhist(AdaptHist);
axis tight;
title('ADAPTHISTEQ histogram');

%% Use Linear Spatial Filter: average out the image to reduce the noise
avg = fspecial('gaussian',10, 20);

cellDenoise = imfilter(AdaptHist,avg);
imshow(cellDenoise);
title('Averaging Filter - Zero Padding');
% imwrite(cellDenoise, 'filter.png')

%% BLOCKPROC
blkSize = [10 10];
[rows,cols] = size(cellDenoise); 

background = blockproc(cellDenoise,blkSize,@blockBackground,'PadMethod','symmetric');

background = imresize(background, [rows cols], 'bilinear');
figure, imshow(background)
title('Background Estimate');
% imwrite(background, 'background.png')

%% Subtract the background from the image
backgroundAdj = cellDenoise - background ;
figure,imshow(backgroundAdj);
title('Background Adjusted Image');

% imwrite(backgroundAdj, 'backgroundAdj.png')

%% Enhance the brightness of the image
cluster = imadjust(backgroundAdj);
figure, imshowpair(cellDenoise, cluster,'montage');
title('Original & the final version of the image');

%% Threshold the image to extract the clusters 
function y = blockBackground(x)
block = x.data;
y = min(block(:));
end