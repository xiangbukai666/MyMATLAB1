function img_enhanced=LinearEnhancement(Img)
    Img_gray=img_gray(Img,0.299,0.587,0.114);
    Img_gray=double(Img_gray); 
    min_val=min(Img_gray(:));
    max_val=max(Img_gray(:));
    contrast_factor=0.5;
    offset=0.5;
    img_enhancedD=contrast_factor*(Img_gray-min_val)/(max_val-min_val)+offset;
    img_enhancedD=min(max(img_enhancedD,0),1);
    img_enhanced=uint8(img_enhancedD*255); 
end