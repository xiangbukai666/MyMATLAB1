function Img_gray=img_gray(Img,r,g,b)
    if size(Img,3)==3
        Img_gray=r*Img(:,:,1)+g*Img(:,:,2)+b*Img(:,:,3);
    else
        Img_gray=Img;
    end
    %一般取值rgb:0.299,0.587,0.114
end