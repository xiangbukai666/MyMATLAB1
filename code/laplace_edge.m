function Img1=laplace_edge(Img)
    Img=im2double(Img);
    [M,N,~]=size(Img); 
    Img1=zeros(size(Img)); 
    H = [0 1 0; 1 -4 1; 0 1 0];
    for c = 1:3
        for x = 2:M-1
            for y = 2:N-1
                neighborhood=Img(x-1:x+1,y-1:y+1,c);
                Img1(x,y,c)=sum(sum(neighborhood .*H));
            end
        end
    end
    Img1=im2uint8(Img1);
end