function Img1=gauss_noise(Img)
    [m, n, z]=size(Img);
    mean=0;
    sd=1;
    y=mean+sd*randn(m,n);
    Img1=double(Img)/255;
    Img1=Img1+y;
    Img1=Img1*255;
    Img1=uint8(Img1);
end