function res_pair = Rectangular_design(this_row, this_column)
% this_row = 3
% this_column = 4;

direction = 1;   %# increment direction:1->,2\|/,3<-,4/|\
    ind = 1; %# initial value, start from (1,1)
    i = 1;
    j = 1;
    mat = zeros(this_row, this_column);
    while (ind<=this_row*this_column)
        if mat(i,j)==0
            mat(i,j) = ind; %# update current position
            ind = ind + 1;   %     # flag add 1
            if direction==1  % # if towards right
                if j+1<= this_column && mat(i,j+1)==0 %: # the next position is valid and the value is 0
                    j = j+1 ;
                else     %: # else, change the direction, the same for the follows
                    i = i + 1;
                    direction = 2;
                end
            elseif direction==2 % towards down
                if i+1<=this_row && mat(i+1,j)==0
                    i = i+ 1;
                else
                    j = j- 1;
                    direction = 3;
                end
            elseif direction==3 % towards left
                if j-1>=1 && mat(i,j-1)==0
                    j = j- 1;
                else
                    i = i- 1;
                    direction = 4;
                end
            elseif direction==4 % towards up
                if i-1>=1 && mat(i-1,j)==0
                    i = i- 1;
                else
                    j = j+ 1;
                    direction = 1;
                end
            end
        end
    end
    
    res_pair = [];
    for i = 1: size(mat,1)
         temp_pair = nchoosek([1:size(mat,2)],2);
         for k = 1:size(temp_pair,1)
         pair = mat(i,temp_pair(k,:));
         res_pair = [res_pair; pair];
         end
    end
    for j = 1: size(mat,2)
         temp_pair = nchoosek([1:size(mat,1)],2);
         for k = 1:size(temp_pair,1)
         pair = mat(temp_pair(k,:),j);
         res_pair = [res_pair; pair'];
         end
    end
    
