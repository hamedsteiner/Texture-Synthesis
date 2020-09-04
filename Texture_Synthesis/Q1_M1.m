clc
clear

apple=im2double(imread('apples.png')); % M1 patch=5
brick=im2double(imread('brick.jpg')); % M1 patch=5*24
grass=im2double(imread('grass.png')); % M1 patch=5*10
radish=im2double(imread('radishes.jpg')); %M1 patch=108
random=im2double(imread('random.png')); % M1 patch>108
random3=im2double(imread('random3.png')); % M1 patch=84
rice=im2double(imread('rice.bmp')); % M1 patch=97
text=im2double(imread('text.jpg')); % M1 patch=108
toast=im2double(imread('toast.png')); %
weave=im2double(imread('weave.jpg')); %

Image=weave;

Size=size(Image);
out_height=5*Size(1);
out_width=5*Size(2);
t_size=size(Size);

if(t_size(2)==2)
    Result=zeros(out_height,out_width,1);
else
    Result=zeros(out_height,out_width,3);
end

psize=85;%patch size

%Method1
for row=1:psize:out_height-(-1)
    for col=1:psize:out_width-(-1)
        if ( row==1 && col==1)
            %select an initial random batch
            i=randi(floor(out_height/5) -psize);
            j=randi(floor(out_width/5) - psize);
            patch=Image(i:i+psize-1,j:j+psize-1,:);
            Result(row:row+psize-1,col:col+psize-1,:)=patch;
        
        else
            i=randi(floor(out_height/5) -psize);
            j=randi(floor(out_width/5) - psize);
            patch=Image(i:i+psize-1,j:j+psize-1,:);
            Result(row:row+psize-1,col:col+psize-1,:)=patch;
        end
    end
end
        
figure,imshowpair(Image,Result, 'montage'),title("Original                    Random Patch Generated Patch size=85");        
            
            
        