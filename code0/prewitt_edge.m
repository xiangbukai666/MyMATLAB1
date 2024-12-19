    Img_double=im2double(imread("0.jpg"));
    [M, N, ~]=size(Img_double);
    I_edgeX=zeros(M,N,3);
    I_edgeY=zeros(M,N,3); 
    I_edge=zeros(M,N,3);
    Prewitt_x=[-1 -1 -1; 0 0 0; 1 1 1];
    Prewitt_y=[-1 0 1; -1 0 1; -1 0 1];
    for c = 1:3 
        for x = 2:M-1
            for y = 2:N-1
                neighborhood=Img_double(x-1:x+1,y-1:y+1,c);
                I_edgeX(x,y,c)=sum(sum(neighborhood.*Prewitt_x));
                I_edgeY(x,y,c)=sum(sum(neighborhood.*Prewitt_y));
            end
        end
    end

    % 计算边缘强度
    for c = 1:3
        I_edge(:,:,c) = sqrt(I_edgeX(:,:,c).^2 + I_edgeY(:,:,c).^2);
    end
    imshow(I_edge);
    
