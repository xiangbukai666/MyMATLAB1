function lbp=displayLBPFeatures(Img)
    if size(Img,3)==3
        Img=rgb2gray(Img);
    end
    [N,M]=size(Img);
    lbp=zeros(N,M); 
    neighborOffsets = [-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];
    for j=2:N-1
        for i=2:M-1
           centerPixel=Img(j, i);
           pattern=0;
           for k=1:8
               offset=neighborOffsets(k, :);
               if Img(j+offset(1),i +offset(2))>centerPixel
                   pattern=pattern+2^(8-k);
               end
           end
           lbp(j,i)=pattern;
       end
    end
    lbp=uint8(lbp*255/(max(lbp(:))+eps));
end
