clc;close all;clear;

% import original image %
RGB = imread('m610110011_hw1_pic.jpg');

figure
imshow(RGB);

%% Transform color image to grayscale image

Igray = rgb2gray(RGB);
figure
imshow(Igray)

%% Plot histogram of gray-scale image
H = imhist(Igray);

figure
bar(H)
xlim([0 255])
xlabel('pixel value')
ylabel('Number')

%% Convert to binary image (1)

BW1 = Igray>100;
BW2 = Igray>180;

figure
subplot(1,2,1), imshow(BW1);
title('I > 100')
subplot(1,2,2), imshow(BW2);
title('I > 180')

%% Convert to binary image (2)
% Get the global threshold for the image. otsu method
thresh = graythresh(Igray);
% Use that threshold to create a binary image.
BW3 = imbinarize(Igray, thresh);

figure
imshow(BW3)

%% Export image
imwrite(BW3,'BinaryImage.png');
