function y = twoside_sampler(in_height,in_width,psize,ovlpsize,Image,out_row,out_col,Result,target_image,errors_pnts)

    [error_vertical,common1] = vertical_sampler(in_height,in_width,psize,ovlpsize,Image,out_row,out_col,Result,target_image,errors_pnts);
    [error_horizontal,common] = horizontal_sampler(in_height,in_width,psize,ovlpsize,Image,out_row,out_col,Result,target_image,errors_pnts);

    % overlapped part reduction is considered in horizontal_sampler 
    errorr=error_vertical+error_horizontal-common;
    y=errorr;
    
end

