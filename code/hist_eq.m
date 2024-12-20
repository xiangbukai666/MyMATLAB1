function hist_eqImg=hist_eq(Img)
    if size(Img,3)==3
       Img=img_gray(Img,0.299,0.587,0.114);
    end
    [rows,cols]=size(Img);
    hist_img=zeros(1,256);
    for i=1:rows
        for j=1:cols
            hist_img(Img(i,j)+1)=hist_img(Img(i,j)+1)+1;
        end
    end
    total_pixels=rows *cols;
    cum_hist=zeros(1, 256);
    cum_hist(1)=hist_img(1)/total_pixels;
    for i=2:256
        cum_hist(i)=cum_hist(i-1)+hist_img(i)/total_pixels;
    end
    cdf_mapped=uint8(cum_hist*255);
    hist_eqImg=cdf_mapped(double(Img)+1)-1;
end