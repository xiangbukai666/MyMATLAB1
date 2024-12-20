function Img1=robert_edge(Img)
    Img=im2double(Img);
    if size(Img,3)==3
        Img1=zeros(size(Img));
    else
        Img1=zeros(size(Img,1), size(Img,2));
    end
    H1=[1 0; 0 -1];
    H2=[0 1; -1 0];
    for c=1:size(Img,3)
        Img1(:,:,c)=abs(conv2(Img(:,:,c),H1,'same'))+abs(conv2(Img(:,:,c),H2,'same'));
    end
end