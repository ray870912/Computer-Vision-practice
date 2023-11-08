%% Import and display the image.
clc;close all;clear;

img = imread('edge_detect.jpg');
figure, imshow(img,[]);
title('Origin')

gray = rgb2gray(img);
thresh = graythresh(gray);
BW = imbinarize(gray, thresh);

figure, imshow(BW);
title('BW')
%% Detect worm edges with default Sobel method.
imgEdge = edge(BW);
imshow(imgEdge);

%% Get the default threshold value.
[imgEdge,t] = edge(BW);

figure, imshow(imgEdge);
title('default threshold')
%% Increase the threshold value to reduce background noise detection.
imgEdge = edge(BW, 0.5);

figure, imshow(imgEdge);
title('threshold = 0.5')
%% Detect worm edges using the Canny operator and observe thethreshold.
[cannyEdge,t] = edge(BW,'canny');

figure, imshow(cannyEdge);
title('default threshold = 0.0063   0.0156')
%% Increase the threshold value to ignore noise detection.
cannyEdge = edge(BW,'canny', 0.9);

figure, imshow(cannyEdge);
title('threshold = 0.9')