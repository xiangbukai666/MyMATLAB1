I=imread("0.jpg");
I = double(I);
[rows,cols,channels]=size(I);
noiseRange=20;
%创建均匀分布噪声
noisyImage=I+randn(rows,cols,channels)*noiseRange;
noisyImage(noisyImage<0)=0;
noisyImage(noisyImage>255)=255;
noisyImage=uint8(noisyImage);
imshow(noisyImage);
