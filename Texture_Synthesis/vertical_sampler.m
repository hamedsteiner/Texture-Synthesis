function [y1,y2] = vertical_sampler(in_height,in_width,psize,ovlpsize,Image,out_row,out_col,Result,target_image,errors_pnts)
    
    errors_same=zeros( (in_height -psize+1) ,(in_width -psize+1));
    
    step=1;
    if ( out_col==1 )
        
        for i=1: step:in_height -psize+1
            for j=1: step:in_width -psize+1 
                patch_ovlp=Image(i:i+ovlpsize-1,j:j+psize-1,:);
                        %analyze new patch from 1 to ovlp, analyze prev patch from col to prevj
                outimage_ovlp=Result( out_row:out_row+ovlpsize-1, out_col:out_col+psize-1, :);
                temp=(outimage_ovlp-patch_ovlp).*(outimage_ovlp-patch_ovlp);
                errors_pnts(i,j)=sum(sum(sum(temp)));
            end
        end
        y2=errors_same;
    else
        for i=1: step:in_height -psize+1
            for j=1: step:in_width -psize+1
                patch_ovlp=Image(i:i+ovlpsize-1,j:j+psize-1,:);
                patch_reduction_ovlp=Image(i:i+ovlpsize-1,j:j+ovlpsize-1,:);
                
                outimage_reduction_ovlp=Result( out_row:out_row+ovlpsize-1, out_col:out_col+ovlpsize-1, :);
                outimage_ovlp=Result( out_row:out_row+ovlpsize-1, out_col:out_col+psize-1, :);
                
                temp=(outimage_ovlp-patch_ovlp).*(outimage_ovlp-patch_ovlp);
                temp_same=(outimage_reduction_ovlp-patch_reduction_ovlp).*(outimage_reduction_ovlp-patch_reduction_ovlp);
                
                errors_pnts( i,j)=sum(sum(sum(temp)));
                errors_same(i,j)=sum(sum(sum(temp_same)));
                
            end
        end
        y2=errors_same;
    end
    y1=errors_pnts;
    
end

