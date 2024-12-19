function [morphImage,edge_I]=feature_extraction(image)
    grayImage = rgb2gray(image);
    bwImage = imbinarize(grayImage);
    SE=strel('square', 3);
    morphImage=imopen(bwImage, SE);
    morphImage=imclose(morphImage, SE);
    edge_I=canny_edge(image);
end
function canny2=canny_edge(image) 
    img=rgb2gray(image);  
    Img=double(img);  
    sz=size(img); 
    %Gaussian卷积平滑滤波
    alf=3;  
    n=7; 
    n0=floor((n+1)/2);
    for i=1:n 
        for j=1:n  
           h(i,j)=exp(-((i-n0)^2+(j-n0)^2)/(2*alf))/(2*pi*alf);  
        end  
     end  
    Img_n=uint8(conv2(Img,h,'same')); 
    M=zeros(sz(1),sz(2));
    theta=zeros(sz(1),sz(2));
    canny1=zeros(sz(1),sz(2));%非极大值抑制
    canny2=zeros(sz(1),sz(2));%双阈值检测和连接
    Img_n=double(Img_n);    
     for i=2:(sz(1)-2)  
         for j=2:(sz(2)-2)  
             %计算x 和 Y 方向的幅度和方向梯度
             Sx=Img_n(i-1,j-1)+2*Img_n(i,j-1)+Img_n(i+1,j-1)-Img_n(i-1,j+1)-2*Img_n(i,j+1)-Img_n(i+1,j+1);  
             Sy=Img_n(i+1,j-1)+2*Img_n(i+1,j)+Img_n(i+1,j+1)-Img_n(i-1,j-1)-2*Img_n(i-1,j)-Img_n(i-1,j+1);  
             M(i,j)=sqrt(Sx^2+Sy^2); 
             theta(i,j)= atan(Sx/Sy);
             %分四个方向进行比较，非极大值抑制
             dirc=theta(i,j);
             if abs(dirc)<=pi/8
                if (M(i,j)>M(i-1,j-1))&&(M(i,j)>M(i+1,j+1))
                    canny1(i, j)=M(i, j);
                end
            elseif abs(dirc)>=3*pi/8
                if (M(i,j)>M(i-1,j-1))&&(M(i,j)>M(i+1,j+1))
                    canny1(i,j)=M(i,j);
                end
            elseif dirc>pi/8&&dirc<3*pi/8
                if (M(i,j)>M(i-1,j-1))&&(M(i,j)>M(i+1,j+1) )
                    canny1(i,j)=M(i,j);
                end
            elseif dirc>-3*pi/8&&dirc<-pi/8
                if (M(i,j)>M(i-1,j-1))&&(M(i,j)> M(i+1,j+1))
                    canny1(i,j) = M(i,j);
                end
             end
         end  
     end   
    %双阈值监测和边缘连接 
    lowTh =0.2*max(max(canny1));%高阈值
    higtTh=0.4*max(max(canny1));%低阈值
    for i=2:sz(1)
        for j=2:sz(2)
            if canny1(i,j)>lowTh&&canny1(i,j)<higtTh
                canny2(i,j)=canny1(i,j);
            end
        end
    end
end
