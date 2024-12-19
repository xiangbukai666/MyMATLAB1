    image=imread("0.jpg");
    if size(image,3)==3
        image=rgb2gray(image);
    end
    [N,M]=size(image);
    lbp=zeros(N,M); 
    neighborOffsets = [-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];
    for j=2:N-1
        for i=2:M-1
           centerPixel=image(j, i);
           pattern=0;
           for k=1:8
               offset=neighborOffsets(k, :);
               if image(j+offset(1),i +offset(2))>centerPixel
                   pattern=pattern+2^(8-k);
               end
           end
           lbp(j,i)=pattern;
       end
    end
    lbp=uint8(lbp*255/(max(lbp(:))+eps));
    imshow(lbp);
