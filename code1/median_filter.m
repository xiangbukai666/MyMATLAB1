function output = median_filter(input_img)
    [m,n,z]=size(input_img);
    output=zeros(m,n,z,'uint8');
    filter_size=3;
    padding_size=floor(filter_size/2);
    padded_img=padarray(input_img,[padding_size,padding_size], 'replicate', 'both');
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