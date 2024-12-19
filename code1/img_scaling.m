function Z_I=img_scaling(Img)
    [IH,IW,~] =size(Img);
    kx=2;
    ky=3;
    Z_IH=round(IH*ky); 
    Z_IW=round(IW*kx); 
    Z_I=zeros(Z_IH,Z_IW,size(Img,3),'uint8');  
    Img1=padarray(Img,[1,1],'replicate','both');
    for zj=1:Z_IW
        for zi=1:Z_IH
            ii=(zi-1)/ky; 
            jj=(zj-1)/kx;
            i=floor(ii); 
            j=floor(jj); 
            u=ii-i; 
            v=jj-j;
            i=min(max(i+1,1),IH+1);
            j=min(max(j+1,1),IW+1);
            % 双线性插值计算
            Z_I(zi,zj,:)=(1-u)*(1-v)*Img1(i,j,:)+(1-u)*v*Img1(i,j+1,:)+u*(1-v)*Img1(i+1,j,:)+u*v*Img1(i+1,j+1,:);
        end
    end
end