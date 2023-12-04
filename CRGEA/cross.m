function [population,EC,fitvalue]=cross(population,fitvalue,EC,b,data,label,K,fold,Pc,cross_number)
        for i=1:size(population,1)
            if Pc>rand
               a=1:size(population,1);
               a(i)=[];
               j=a(randperm(length(a),1));  
               cross_number1=randperm(cross_number,1);
               cross_position=sort(randperm(b,cross_number1));
               pop_i=population(i,:);pop_i_value=fitvalue(i,:);new_i=pop_i;
               pop_j=population(j,:);pop_j_value=fitvalue(j,:);new_j=pop_j;
               cross_gen=new_i(:,cross_position);
               new_i(:,cross_position)=new_j(:,cross_position);
               new_j(:,cross_position)=cross_gen;
               new_i_value=decode(new_i,data,K,fold,label);
               new_j_value=decode(new_j,data,K,fold,label);
               chazhi_i=pop_i_value-new_i_value;
               if sum(new_i)>0&(length(find(new_i>0))>0)  
                   if (new_i_value(1)<pop_i_value(1))&(new_i_value(2)<pop_i_value(2))
                       population(i,:)=new_i;fitvalue(i,:)=pop_i_value;
                   elseif (new_i_value(1)==pop_i_value(1))&(new_i_value(2)<pop_i_value(2))
                       population(i,:)=new_i;fitvalue(i,:)=pop_i_value;
                   elseif (new_i_value(1)<pop_i_value(1))&(new_i_value(2)==pop_i_value(2))
                       population(i,:)=new_i;fitvalue(i,:)=pop_i_value;
                   else 
                       if (length(find(chazhi_i>0))==1)&(length(find(chazhi_i<0))==1)
                           EC=[EC;[new_i_value,new_i]];
                       end
                   end
               end
               chazhi_j=pop_j_value-new_j_value;
               if sum(new_j)>0&(length(find(new_j>0))>0) 
                   if (new_j_value(1)<pop_j_value(1))&(new_j_value(2)<pop_j_value(2))
                       population(j,:)=new_j;fitvalue(j,:)=pop_j_value;
                   elseif (new_j_value(1)==pop_j_value(1))&(new_j_value(2)<pop_j_value(2))
                       population(i,:)=new_j;fitvalue(i,:)=pop_j_value;
                   elseif (new_j_value(1)<pop_j_value(1))&(new_j_value(2)==pop_j_value(2))
                       population(i,:)=new_j;fitvalue(i,:)=pop_j_value;
                   else 
                       if (length(find(chazhi_j>0))==1)&(length(find(chazhi_j<0))==1)
                           EC=[EC;[new_j_value,new_j]];
                       end
                   end
               end
            end
        end