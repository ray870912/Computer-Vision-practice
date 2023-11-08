clc;clear;close all
%% retinaPhaseCorr
fixed = imread('before.jpg');
moving = imread('after.jpg');
figure, imshowpair(fixed,moving,'montage');

tformEstimate = imregcorr(moving,fixed,'similarity');

Rfixed = imref2d(size(fixed));

output = imwarp(moving,tformEstimate,'OutputView',Rfixed);

figure,imshowpair(output,fixed,'diff')

%% retinaSpatialTransform

hFig = figure;
subplot(2,1,1), 
imshowpair(fixed,moving,'montage')
title('Fixed and Moving Images')

cpselect(moving,fixed)
%% after select the point
fixedGray = rgb2gray(fixed);
movingGray = rgb2gray(moving);

movPtsCorr = cpcorr(movingPoints, fixedPoints, movingGray, fixedGray);

mytform = fitgeotrans(movPtsCorr,fixedPoints,'similarity');

refDim = size(fixed);
Rfixed = imref2d(refDim);

output = imwarp(moving,mytform,'OutputView',Rfixed);

figure(hFig), 
subplot(2,1,2), 
imshowpair(fixed,output,'montage') 
title('Fixed and Output Images')

figure,imshowpair(output,fixed)
