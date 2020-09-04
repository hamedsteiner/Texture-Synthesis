function [y1,y2] = patch_transfer(in_height,in_width,psize,ovlpsize,target_image,source_image,out_row,out_col,Result,tol,alpha)%,prev_patch)

        errors_pnts=zeros( (in_height -psize+1) , (in_width -psize+1) );
        errors_diff_texture=zeros( (in_height -psize+1) , (in_width -psize+1) );
        %errors_diff_patches=zeros( (in_height -psize+1) , (in_width -psize+1) );
        
        
        if ( out_row==1 )%only horizontal overalpping error   
            [errors_pnts,~] = horizontal_sampler(in_height,in_width,psize,ovlpsize,source_image,out_row,out_col,Result,target_image,errors_pnts); 
        
        elseif ( out_col==1 )%only vertical
            [errors_pnts,~] = vertical_sampler(in_height,in_width,psize,ovlpsize,source_image,out_row,out_col,Result,target_image,errors_pnts);
        
        else
            errors_pnts = twoside_sampler(in_height,in_width,psize,ovlpsize,source_image,out_row,out_col,Result,target_image,errors_pnts);

        end

        
        
        %if(out_col==1)% the previous patch is from previous line!
            %prev_patch=zeros(psize,psize,3);
        %end
        
            
        for i=1: in_height -psize+1
            for j=1: in_width -psize+1     
                src_img=rgb2gray(source_image(i:i+psize-1,j:j+psize-1,:));
                trgt_img=rgb2gray(target_image( out_row:out_row+psize-1, out_col:out_col+psize-1, :));
                temp=(trgt_img-src_img).*(trgt_img-src_img);
                
                %diff_pathes=(prev_patch-src_img).*(prev_patch-src_img);
                
                %errors_diff_patches(i,j)=sum(sum(sum(diff_pathes)));
                errors_diff_texture(i,j)=sum(sum(sum(temp)));
            end
        end
        
        
        errors_pnts= alpha*(errors_pnts)+(1-alpha)*errors_diff_texture;
        %+errors_diff_patches
        
        
        min_error=min(min(errors_pnts));
        if(min_error==0)
            [samples_x,samples_y]=find(errors_pnts==min_error); 
        else
            [samples_x,samples_y]=find(errors_pnts<min_error*(tol+1));
        end
        t=size(samples_x);
        token=randi(t(1));
        y1=samples_x(token);
        y2=samples_y(token);
        

end