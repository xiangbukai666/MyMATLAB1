function img_ycbcr=ycbcr_img(img)
    R2=double(img(:,:,1));
    G2=double(img(:,:,2));
    B2=double(img(:,:,3));
    %公式转换计算 YCbCr
    Y1=0.299*R2+0.587*G2+0.114*B2;
    Pb=-0.1687*R2-0.3313*G2+0.500*B2; 
    Pr=0.500*R2-0.4187*G2-0.0813*B2; 
    Y=219*(Y1/255)+16;
    Cb=224*(Pb/255)+128;    
    Cr=224*(Pr/255)+128;    
    % 转换为[0, 255]范围内
    Y=uint8(min(max(Y,0),255));
    Cb=uint8(min(max(Cb,0),255));
    Cr=uint8(min(max(Cr,0),255));
    % 创建YCbCr图像显示
    img_ycbcr=cat(3,Y,Cb,Cr);
end
