    I=imread("0.jpg");
    I=im2double(I);
    [M,N,~]=size(I); 
    Img=zeros(size(I)); 
    H = [0 1 0; 1 -4 1; 0 1 0];
    for c = 1:3
        for x = 2:M-1
            for y = 2:N-1
                neighborhood = I(x-1:x+1, y-1:y+1, c);
                Img(x, y, c) = sum(sum(neighborhood .* H));
            end
        end
    end
    Img = im2uint8(Img);
    imshow(Img);