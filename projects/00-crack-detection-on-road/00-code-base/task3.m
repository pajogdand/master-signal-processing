clc
clear all

img = imread('1.tif');

spoint = [51, 127];
epoint = [265, 122];

% img = imread('1D560244-3x.tif');
% spoint = [898, 220];
% epoint = [628, 218];

% img = imread('2.jpg');
% 
% spoint = [359, 146];
% epoint = [367, 545];

% img = imread('1D560445-3x.tif');
% spoint = [378, 124];
% epoint = [772, 120];


% img = imread('1D578709-3x.tif');
% spoint = [626, 198];
% epoint = [902, 212];

% img = imread('1D579633-3x.tif');
% spoint = [229, 70];
% epoint = [566, 110];


% img = imread('1D588192.tif');
% spoint = [218, 108];
% epoint = [117, 408];

% img = imread('InImage.tif');
% spoint = [224, 214];
% epoint = [708, 212];

img = img(:,:,1);
subplot(1,2,1);
imshow(img);
% 
w = 0;
TH = 10;
r_max = 15;


% Get a minimal action map U0
% U - a minimal action map U0(p), R - the radius of sphere centered at the
% point p.

[U, R] = getUmap(img, spoint, epoint, w, r_max, TH);

[rows, cols] = size(img);

% Get the result_img which replace path with white color
rlt_img = path_3D(rows, cols, img, spoint, epoint, U, R);

rlt_img = uint8(rlt_img);
subplot(1,2,2);
imshow(rlt_img);
