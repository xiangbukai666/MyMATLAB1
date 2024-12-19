    img=imread("0.jpg");
    if size(img,3)==3
        img=img_gray(img,0.299,0.587,0.114);
    end
    % 计算原始图像的直方图
    [rows,cols]=size(img);
    hist_img=zeros(1,256);
    for i=1:rows
        for j=1:cols
            hist_img(img(i,j)+1)=hist_img(img(i,j)+1)+1;
        end
    end
    imshow(hist_img);