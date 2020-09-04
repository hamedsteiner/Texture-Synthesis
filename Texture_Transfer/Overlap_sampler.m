function [y1,y2] = Overlap_sampler(in_height,in_width,psize,ovlpsize,Image,out_row,out_col,Result,tol)

        errors_pnts=zeros( (in_height -psize+1) , (in_width -psize+1) );
        if ( out_row==1 )%only horizontal overalpping error   
            
            
            [errors_pnts,~] = horizontal_sampler(in_height,in_width,psize,ovlpsize,Image,out_row,out_col,Result,Image,errors_pnts); 

        elseif ( out_col==1 )%only vertical
            [errors_pnts,~] = vertical_sampler(in_height,in_width,psize,ovlpsize,Image,out_row,out_col,Result,Image,errors_pnts);
            
        else
            errors_pnts = twoside_sampler(in_height,in_width,psize,ovlpsize,Image,out_row,out_col,Result,Image,errors_pnts);

        end

        
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
        
        
%[~, idx] = find(A > -Inf, n, 'first')






end