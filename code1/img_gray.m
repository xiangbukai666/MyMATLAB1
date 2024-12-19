function Img_gray=img_gray(Img)
    if size(Img,3)==3
        Img_gray=0.299*Img(:,:,1)+0.587*Img(:,:,2)+0.114*Img(:,:,3);
    else
        Img_gray=Img;
    end
end