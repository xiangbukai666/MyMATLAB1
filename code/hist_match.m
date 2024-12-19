function img_histMatch=hist_match(img,b,c)
    if size(img,3)==3
        img=img_gray(img,0.299,0.587,0.114);
    end
    [rows,cols]=size(img);
    hist_img=zeros(1, 256);
    for i=1:rows
        for j=1:cols
            hist_img(img(i,j)+1)=hist_img(img(i,j)+1)+1;
        end
    end
    total_pixels=rows*cols;
    cum_hist=zeros(1,256);
    cum_hist(1)=hist_img(1)/total_pixels;
    for i=2:256
        cum_hist(i)=cum_hist(i-1)+hist_img(i)/total_pixels;
    end
    n=0:255;
    target_hist=exp(-(n-b).^2/(2*c^2));
    target_hist=target_hist/sum(target_hist);
    cum_target_hist=cumsum(target_hist); % 计算累积分布函数
    img_histMatch=zeros(rows, cols);
    for i = 1:rows
        for j = 1:cols
            pixel_val=img(i,j);
            [~, idx]=min(abs(cum_hist(pixel_val+1)-cum_target_hist));
            img_histMatch(i,j)=idx-1;
        end
    end
    img_histMatch=uint8(img_histMatch);
end