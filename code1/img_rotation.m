function rotated_Img=img_rotation(Img)
    ImgD=double(Img); 
    [H,W,C]=size(ImgD);
    angle=30;
    radian=deg2rad(angle);
    %计算旋转后新尺寸以及旋转中心
    new_H = round(abs(H * cos(radian))+abs(W * sin(radian)));
    new_W = round(abs(W * cos(radian)) + abs(H * sin(radian)));
    centerX = W / 2;
    centerY = H / 2;
    new_centerX = new_W / 2;
    new_centerY = new_H / 2;
    rotated_Img = zeros(new_H, new_W, C);
    % 双线性插值填充新图像
    for x_new = 1:new_W
        for y_new = 1:new_H
            x_old = (x_new - new_centerX) * cos(radian) - (y_new - new_centerY) * sin(radian) + centerX;
            y_old = (x_new - new_centerX) * sin(radian) + (y_new - new_centerY) * cos(radian) + centerY;
            % 获取整数部分和小数部分
            x1 = floor(x_old);
            x2 = ceil(x_old);
            y1 = floor(y_old);
            y2 = ceil(y_old);  
            % 边界检查
            if (x1 >= 1) && (x2 <= W) && (y1 >= 1) && (y2 <= H)
                % 计算双线性插值
                for c = 1:C
                    Q11 = ImgD(y1, x1, c);
                    Q12 = ImgD(y2, x1, c);
                    Q21 = ImgD(y1, x2, c);
                    Q22 = ImgD(y2, x2, c);  
                    % 计算插值
                    dx = x_old - x1;
                    dy = y_old - y1;
                    rotated_Img(y_new, x_new, c) = (1 - dx) * (1 - dy) * Q11 + dx * (1 - dy) * Q21+(1-dx)*dy*Q12+dx*dy*Q22;
                end
            end
        end
    end
    rotated_Img=uint8(rotated_Img);
end