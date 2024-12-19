function img_EX=ExEnhancement(Img,gamma)
    Img_gray=img_gray(Img,0.299,0.587,0.114);
    Img_gray=double(Img_gray); 
    min_val=min(Img_gray(:));
    max_val=max(Img_gray(:));
    img_enhancedEX=((Img_gray - min_val) / (max_val-min_val)).^gamma;
    img_EX=uint8(img_enhancedEX*255); 
end