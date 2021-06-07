function imSteg = waveletSteganography(im,im_stego,wvlet)

X = im;
[c,s]=wavedec2(X,2,wvlet);

[H1,V1,D1] = detcoef2('all',c,s,1);
A1 = appcoef2(c,s,wvlet,1);


[H2,V2,D2] = detcoef2('all',c,s,2);
A2 = appcoef2(c,s,wvlet,2);


H1=zeros(size(H1));
H1(1:size(im_stego,1), 1:size(im_stego,2)) = im_stego;


c2 = [A2(:)' , H2(:)' , V2(:)' , D2(:)' , H1(:)' , V1(:)' , D1(:)'];
im2 = waverec2(c2,s,wvlet);
imSteg = im2;

end