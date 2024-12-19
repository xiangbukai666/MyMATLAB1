    Img=imread("0.jpg");
    Img_gray=img_gray(Img,0.299,0.587,0.114);
    Img_gray = double(Img_gray); 
    img_logD=log(Img_gray+1);
    min_valLog=min(img_logD(:));
    max_valLog=max(img_logD(:));
    img_normalized=(img_logD-min_valLog)/(max_valLog-min_valLog);
    img_log=uint8(img_normalized*255); 
    imshow(img_log);