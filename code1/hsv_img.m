function img_hsv=hsv_img(img)
    R1=double(img(:,:,1))/255; % 提取RGB变量归一化
    G1=double(img(:,:,2))/255;
    B1=double(img(:,:,3))/255;
    % 计算亮度V，色度C
    V=max(R1, max(G1, B1));
    C=V-min(R1,min(G1,B1));
    % 初始化色相H和饱和度S
    H=zeros(size(V));
    S=zeros(size(V));
    S(V==0) = 0; % 无法定义无色的饱和度
    S(V>0)=C(V>0)./V(V>0);
    H(V==0)=NaN; % 无法定义灰色以及无颜色的色相
    % 对于不同的最大值，应用公式计算 H
    maskR=(V==R1)&(C>0);
    maskG=(V==G1)&(C>0);
    maskB=(V==B1)&(C>0);
    H(maskR)=60*mod((G1(maskR)-B1(maskR))./C(maskR),6);
    H(maskG)=60*((B1(maskG)-R1(maskG))./C(maskG)+2);
    H(maskB)=60*((R1(maskB)-G1(maskB))./C(maskB)+4);
    H(H<0)=H(H<0)+360;
    img_hsv =cat(3,H/360,S,V);

