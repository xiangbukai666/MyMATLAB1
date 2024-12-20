function hist_img=hist_display(Img)
    if size(Img,3)==3
        Img=img_gray(Img,0.299,0.587,0.114);
    end
    % 计算原始图像的直方图
    [rows,cols]=size(Img);
    hist_img=zeros(1,256);
    for i=1:rows
        for j=1:cols
            hist_img(Img(i,j)+1)=hist_img(Img(i,j)+1)+1;
        end
    end
end