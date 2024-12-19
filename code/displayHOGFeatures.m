function hogImage=displayHOGFeatures(image)
    img = double(rgb2gray(imread('pic\0.jpg'))); % 读取并转换为灰度图像
    [N, M]=size(img);
    img =sqrt(img); % 进行开方操作
    % 定义 Sobel 算子进行边缘检测
    Hy=[-1 0 1]; 
    Hx=Hy'; % Sobel 算子
    Gy=imfilter(img,Hy,'replicate'); % 纵向梯度
    Gx=imfilter(img,Hx,'replicate'); % 横向梯度
    Grad=sqrt(Gx.^2+Gy.^2); % 梯度幅值 
    % 计算相位角度
    Phase=zeros(N,M);
    Eps=0.0001; % 初始化相位矩阵
    for i=1:M
        for j=1:N
            if abs(Gx(j,i))<Eps&&abs(Gy(j,i))<Eps
                Phase(j, i) = 270; % 没有梯度的情况
            elseif abs(Gx(j,i))<Eps&&abs(Gy(j,i))>Eps
                Phase(j,i)=90; % 垂直边缘
            else
                Phase(j,i)=atan(Gy(j, i)/Gx(j,i))*180/pi; % 计算梯度方向
                if Phase(j,i)<0
                    Phase(j,i) = Phase(j,i)+180; % 保证相位在[0, 180]区间内
                end
            end
        end
    end
    % 可视化梯度幅值和相位
    figure;
    subplot(121);
    imshow(Grad,[]);
    title('Gradient Magnitude');
    subplot(122);
    imshow(Phase,[]);
    title('Gradient Phase');
    end
