function imSteg = waveletSteganographyModified(im,im_stego,wvlet)

X = im;
[c,s]=wavedec2(X,4,wvlet);

[H1,V1,D1] = detcoef2('all',c,s,1);
A1 = appcoef2(c,s,wvlet,1);


[H2,V2,D2] = detcoef2('all',c,s,2);
[H3,V3,D3] = detcoef2('all',c,s,3);
[H4,V4,D4] = detcoef2('all',c,s,4);
A4 = appcoef2(c,s,wvlet,4);


H1=zeros(size(H1));
H1(1:size(im_stego,1), 1:size(im_stego,2)) = im_stego;

c2 = [A4(:)' , H4(:)' , V4(:)' , D4(:)' , H3(:)' , V3(:)' , D3(:)',...
     H2(:)' , V2(:)' , D2(:)' , H1(:)' , V1(:)' , D1(:)'];

%c2 = [A2(:)' , H2(:)' , V2(:)' , D2(:)' , H1(:)' , V1(:)' , D1(:)'];
im2 = waverec2(c2,s,wvlet);
imSteg = im2;

end