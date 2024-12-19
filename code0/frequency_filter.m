function frequency_filter()
    original_image=imread("0.jpg");
    filtered_image=zeros(size(original_image),'uint8');
    for channel=1:3
        color_channel=original_image(:,:,channel);
        color_channel_double=double(color_channel);
        %对图像进行傅里叶变换并中心化
        [rows, cols]=size(color_channel_double);
        F=fft2(color_channel_double);
        F_center=fftshift(F);
        H=create_low_pass_filter(rows, cols,D0);
        G = H .* F_center;
        %逆傅里叶变换并中心化
        G_shift=ifftshift(G);
        filtered_channel_double=ifft2(G_shift);
        filtered_image(:,:,channel)=uint8(real(filtered_channel_double));
    end
    imshow(filtered_image);
end

function H = create_low_pass_filter(rows, cols,D0)
    H = zeros(rows, cols);
    [u, v] = meshgrid(-floor(cols/2):floor(cols/2)-1, -floor(rows/2):floor(rows/2)-1);
    D = sqrt(u.^2 + v.^2);
    H(D <= 70) = 1;
end