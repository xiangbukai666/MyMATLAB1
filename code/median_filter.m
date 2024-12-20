function output=median_filter(Img,filter_size)
    [m,n,z]=size(Img);
    output=zeros(m,n,z,'uint8');
    padding_size=floor(filter_size/2);
    padded_img=padarray(Img,[padding_size,padding_size], 'replicate', 'both');
    for i=1:m
        for j=1:n
            for k=1:z
                window=padded_img(i:i+filter_size-1, j:j+filter_size-1, k);
                output(i,j,k) = median(window(:));
            end
        end
    end
    output=uint8(output);
end