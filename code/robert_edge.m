function Img=robert_edge(img)
    img=im2double(img);
    if size(img,3)==3
        Img=zeros(size(img));
    else
        Img=zeros(size(img,1), size(img,2));
    end
    H1=[1 0; 0 -1];
    H2=[0 1; -1 0];
    for c=1:size(img,3)
        Img(:,:,c)=abs(conv2(img(:,:,c),H1,'same'))+abs(conv2(img(:,:,c),H2,'same'));
    end
end