function y = path_finder(psize,ovlpsize,out_row,out_col,Result,patch)
    
    vertical_energy=zeros(psize,ovlpsize);
    horizontal_energy=zeros(ovlpsize,psize);
    
    
    
    out_horizon_ovrlp=Result( out_row:out_row+ovlpsize-1, out_col:out_col+psize-1, :);    % try to find a seam curving horizontally
    patch_horizon_ovrlp=patch(1:1+ovlpsize-1,1:1+psize-1,:);
    error_horizontal=(out_horizon_ovrlp-patch_horizon_ovrlp).*(out_horizon_ovrlp-patch_horizon_ovrlp);
    horizontal_energy=sum(error_horizontal,3);
        
    out_vertical_orvlp=Result( out_row:out_row+psize-1, out_col:out_col+ovlpsize-1, :); % try to find a seam curving vertically
    patch_vertical_ovrlp=patch(1:1+psize-1,1:1+ovlpsize-1,:);
    error_vertical=(out_vertical_orvlp-patch_vertical_ovrlp).*(out_vertical_orvlp-patch_vertical_ovrlp);
    vertical_energy=sum(error_vertical,3);     
        
        
    if ( out_row==1 )% find VERTICAL path
        path_vert_y = vertical_pathfinder(psize,ovlpsize,out_row,out_col,vertical_energy);
        for i=out_row:out_row+psize-1
            Result(i,out_col+path_vert_y(i-out_row+1)-1:out_col+psize-1,:)=patch(i-out_row+1,path_vert_y(i-out_row+1):end,:);
        end        

    elseif ( out_col==1 )% find HORIZONTAL path
        path_horiz_x = horizontal_pathfinder(psize,ovlpsize,out_row,out_col,horizontal_energy);
         for i=out_col:out_col+psize-1
            Result(out_row+path_horiz_x(i-out_col+1)-1:out_row+psize-1,i,:)=patch(path_horiz_x(i-out_col+1):end,i-out_col+1,:);
         end   
     
         
         
         
         
         
    % should keep a previous result for next seam!!!
    else % find path at both sides
        prev_Result=Result;
        path_horiz_x = horizontal_pathfinder(psize,ovlpsize,out_row,out_col,horizontal_energy);
        path_vert_y = vertical_pathfinder(psize,ovlpsize,out_row,out_col,vertical_energy);
        
        for j=out_col:out_col+psize-1
            Result(out_row+path_horiz_x(j-out_col+1)-1:out_row+psize-1,j,:)=patch(path_horiz_x(j-out_col+1):end,j-out_col+1,:);
        end
        
        %now we should consider getting the left side to Prev Result
        for i=out_row:out_row+psize-1
            Result(i,out_col:out_col+path_vert_y(i-out_row+1)-1,:)=prev_Result(i,out_col:out_col+path_vert_y(i-out_row+1)-1,:);
            Result(i,out_col+path_vert_y(i-out_row+1)-1:out_col+psize-1,:)=patch(i-out_row+1,path_vert_y(i-out_row+1):end,:);
        end
        
        for j=out_col:out_col+psize-1
            Result(out_row:out_row+path_horiz_x(j-out_col+1)-1,j,:)=prev_Result(out_row:out_row+path_horiz_x(j-out_col+1)-1,j,:);
        end        
    end
    
    y=Result;

end