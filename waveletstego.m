% Wavelet steganography scheme
close all;
clear all;


%% 1 
% Read in the input data and set script parameters
im = imread("coverimage1024.jpg");
im_stego = imread("stegoimage512.png");

im = im2gray(im);
im_stego = im2gray(im_stego);

% normalize hidden image
im_stego = double(im_stego)/255;

%set wavelet
wvlet = 'haar'
%% 2
% Call the waveletSteganography() routine to process the image data
stegoimage = waveletSteganography(im,im_stego,wvlet);
imshow(uint8(stegoimage));

%% 3
% Reconstruct the hidden image
[c,s] = wavedec2(stegoimage,2,wvlet);
[H1,V1,D1] = detcoef2('all',c,s,1);
rec = H1(1:size(im_stego,1),1:size(im_stego,2));

figure;
imshow(rec)




%% 4
% Do comparisons
% Print and visualize results
psnrCover = psnr(im,uint8(stegoimage));
l2errorCover = norm(double(im(:)) - stegoimage(:)) /norm(double(im(:)));
structsimCover = ssim(double(im),stegoimage);
fprintf("Cover Image PSNR=%1.2f, Relative L2 Error %1.2f, SSIM %1.2f \n",...
psnrCover,l2errorCover,structsimCover);

psnrHidden = psnr(rec,im_stego);
l2errorHidden = norm(im_stego(:) - rec(:)) /norm(im_stego(:));
structsimHidden = ssim(im_stego,rec);
fprintf("Recovered Hidden Image PSNR=%1.2f, Relative L2 Error %1.2f, SSIM %1.2f\n",...
psnrHidden,l2errorHidden,structsimHidden);

%% 5
% Visualize the method by checking the wavelet coefficients of the
% acquired stegoimage
[H1,V1,D1] = detcoef2('all',c,s,1);
A1 = appcoef2(c,s,wvlet,1);

V1img = wcodemat(V1,255,'mat',1);
H1img = wcodemat(H1,255,'mat',1);
D1img = wcodemat(D1,255,'mat',1);
A1img = wcodemat(A1,255,'mat',1);

figure;

subplot(2,2,1)
imagesc(A1img)
colormap pink(255)
title('Approximation Coef. of Level 1')

subplot(2,2,2)
imagesc(H1img)
title('Horizontal Detail Coef. of Level 1')

subplot(2,2,3)
imagesc(V1img)
title('Vertical Detail Coef. of Level 1')

subplot(2,2,4)
imagesc(D1img)
title('Diagonal Detail Coef. of Level 1')