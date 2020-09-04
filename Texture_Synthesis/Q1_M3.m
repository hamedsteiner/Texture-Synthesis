clc
clear

apple=im2double(imread('apples.png')); % M1 patch=5
brick=im2double(imread('brick.jpg')); % M1 patch=5*24
grass=im2double(imread('grass.png')); % M1 patch=5*10
radish=im2double(imread('radishes.jpg')); %M1 patch=108
random=im2double(imread('random.png')); % M1 patch>108
random3=im2double(imread('random3.png')); % M1 patch=84
rice=im2double(imread('rice.bmp')); %  patch=40
text=im2double(imread('text.jpg')); % M1 patch=108
toast=im2double(imread('toast.png')); % M1 patch=20
weave=im2double(imread('weave.jpg')); %

Image=random3;

Size=size(Image);
in_height=Size(1);
in_width=Size(2);
out_height=5*Size(1);
out_width=5*Size(2);
t_size=size(Size);
if(t_size(2)==2)
    Result=ones(out_height,out_width,1);
else
    Result=ones(out_height,out_width,3);
end

psize=45;%patch size
ovlpsize=floor(psize/6);
tol=0.25;

%Method3


for out_row=1:psize-ovlpsize:out_height-(psize-1)
    remaining=out_height-(ovlpsize-1)-out_row
    for out_col=1:psize-ovlpsize:out_width-(psize-1)
        %patchfinder, store error, i,j top left of patch
        if ( out_row==1 && out_col==1)%select an initial random batch
            i=randi(in_height - psize);
            j=randi(in_width - psize);
            patch=Image(i:i+psize-1,j:j+psize-1,:); 
            Result(out_row:out_row+psize-1,out_col:out_col+psize-1,:)=patch;
        else
            [patch_x, patch_y] = Overlap_sampler(in_height,in_width,psize,ovlpsize,Image,out_row,out_col,Result,tol); % we got a suitable patch
            
            patch=Image(patch_x:patch_x+psize-1,patch_y:patch_y+psize-1,:);
            Result=path_finder(psize,ovlpsize,out_row,out_col,Result,patch); 
        end
    end
end
        
%figure,imshowpair(Image,Result, 'montage'),title("source                     Method3 patch="+psize+ " overlap ="+ovlpsize);        
figure,imshow(Result),title("Method3 patch="+psize+ " overlap ="+ovlpsize);            
            
        