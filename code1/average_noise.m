function noisyImage=average_noise(I)
    I = double(I);
    [rows,cols,channels]=size(I);
    %创建均匀分布噪声
    noiseRange=20;
    noisyImage=I+randn(rows,cols,channels)*noiseRange;
    noisyImage(noisyImage<0)=0;
    noisyImage(noisyImage>255)=255;
    noisyImage=uint8(noisyImage);
end