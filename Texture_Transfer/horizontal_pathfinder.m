function path_x = horizontal_pathfinder(psize,ovlpsize,out_row,out_col,horizontal_energy)

    Size=size(horizontal_energy);
    e_height=Size(1);
    e_width=Size(2);
    M = horizontal_energy;% score matrix
    
    for j=1: e_width
        for i=1: e_height 
            if(j>1)
                if(i==1)
                    M(i,j)=M(i,j)+min([horizontal_energy(i,j-1),horizontal_energy(i+1,j-1)]);
                elseif(i==e_height)
                    M(i,j)=M(i,j)+min([horizontal_energy(i-1,j-1),horizontal_energy(i,j-1)]);
                else
                    M(i,j)=min([horizontal_energy(i-1,j-1),horizontal_energy(i,j-1),horizontal_energy(i+1,j-1)]);
                end
            end
        end
    end

    Min_path=zeros(e_height,e_width);
    [min_i,~]=find(M(:,e_width)==min(M(:,e_width)));
    Min_path(min_i(1),e_width)=1;
    prev_i=min_i(1);
    for j=e_width:-1:2
        if(prev_i==e_height)
            if( M(prev_i-1,j-1) < M(prev_i,j-1))
                prev_i=prev_i-1;
            end    
            Min_path(prev_i,j-1)=1;
                    
        elseif(prev_i==1)
            if( M(prev_i+1,j-1) < M(prev_i,j-1))
                prev_i=prev_i+1;
            end    
            Min_path(prev_i,j-1)=1;            

        else
            
            if( M(prev_i-1,j-1) < M(prev_i,j-1))
                if( M(prev_i+1,j-1) < M(prev_i-1,j-1))
                    prev_i=prev_i+1;
                else
                    prev_i=prev_i-1;
                end
                
            elseif ( M(prev_i+1,j-1) < M(prev_i,j-1))
                prev_i=prev_i+1;

            end

            Min_path(prev_i,j-1)=1;
        end     
    end
    %%FIND DOES NOT GIVE US IN ORDER X
    path_x=zeros(e_width,1);
    
    for j=1:e_width
        path_x(j)=find(Min_path(:,j)==1);
    end

end

