    Img=imread("0.jpg");
    Img_double=im2double(Img);
    [M, N, ~]=size(Img_double); 
    I_edgeX=zeros(M,N,3); 
    I_edgeY=zeros(M,N,3);
    I_edge=zeros(M,N,3);
    %Sobel算子的x和y方向模板
    Sobel_x=[-1 -2 -1; 0 0 0; 1 2 1];
    Sobel_y=[-1 0 1; -2 0 2; -1 0 1];
    for c = 1:3 %遍历每个颜色通道
        for x = 2:M-1
            for y = 2:N-1
                neighborhood = Img_double(x-1:x+1, y-1:y+1, c);
                I_edgeX(x, y, c) = sum(sum(neighborhood .* Sobel_x));
                I_edgeY(x, y, c) = sum(sum(neighborhood .* Sobel_y));
            end
        end
    end
    for c = 1:3
        I_edge(:,:,c) = sqrt(I_edgeX(:,:,c).^2 + I_edgeY(:,:,c).^2);
    end
    imshow(I_edge);