function path_y = vertical_pathfinder(psize,ovlpsize,out_row,out_col,vertical_energy)

    Size=size(vertical_energy);
    e_height=Size(1);
    e_width=Size(2);
    M = vertical_energy;% score matrix
    
    for i=2: e_height
        for j=1: e_width 
            if(j==1)
                M(i,j)=M(i,j)+min([vertical_energy(i-1,j),vertical_energy(i-1,j+1)]);
            elseif(j==e_width)
                M(i,j)=M(i,j)+min([vertical_energy(i-1,j-1),vertical_energy(i-1,j)]);
            else
                M(i,j)=min([vertical_energy(i-1,j-1),vertical_energy(i-1,j),vertical_energy(i-1,j+1)]);
            end
        end
    end
    
    % Now we need to save a path from bottom up
    
    Min_path=zeros(e_height,e_width); 
    [~,min_j]=find(M(e_height,:)==min(M(e_height,:)));
    
    Min_path(e_height,min_j(1))=1;
    prev_j=min_j(1);
    
    for i=e_height:-1:2
        if(prev_j==e_width)
            if( M(i-1,prev_j-1) < M(i-1,prev_j))
                prev_j=prev_j-1;
            end    
            Min_path(i-1,prev_j)=1;
                    
        elseif(prev_j==1)
            if( M(i-1,prev_j+1) < M(i-1,prev_j))
                prev_j=prev_j+1;
            end    
            Min_path(i-1,prev_j)=1;            

        else
            if( M(i-1,prev_j-1) < M(i-1,prev_j))
                if( M(i-1,prev_j+1) < M(i-1,prev_j-1))
                    prev_j=prev_j+1;
                else
                    prev_j=prev_j-1;
                end
            elseif ( M(i-1,prev_j+1) < M(i-1,prev_j))
                prev_j=prev_j+1;

            end

            Min_path(i-1,prev_j)=1;
        end 
    end
    
    %%FIND DOES NOT GIVE US IN ORDER Y
    
    path_y=zeros(e_height,1);
    
    for i=1:e_height
        path_y(i)=find(Min_path(i,:)==1);
    end
    
    

    

end

