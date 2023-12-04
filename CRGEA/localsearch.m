function [newpopulation,EC,fitvalue]=localsearch(population,data,K,fold,label,Ts,Rate,Tc,Tmin,EC,CR)
newpopulation=population(:,3:end);
fitvalue=population(:,1:2);
for i=1:size(newpopulation,1)
         Ts1=Ts;
         new_TS=Ts1;
         while new_TS>Tmin
             Ts1=new_TS;
             new_TS=Ts1*Rate;
             for j=1:Tc
                 pop=newpopulation(i,:);pop_value=fitvalue(i,:);
                 %add
                 a=1:size(newpopulation,2);
                 gen_position=find(pop==1);
                 a(:,gen_position)=[]; 
                 pop1=pop;pop1_value=pop_value;
                 if length(a)>0 
                    CR_add=CR(:,a);
                    [~,b1]=max(CR_add);
                    add_position=a(b1); 
                    pop1(:,add_position)=1;
                    pop1_value=decode(pop1,data,K,fold,label);                 
                 end
                 %delete
                 pop2=pop;pop2_value=pop_value;
                 CR_add=CR(:,gen_position);
                 [~,b1]=min(CR_add);
                 de_position=gen_position(b1); 
                 aaa=pop2;
                 aaa(:,de_position)=0;
                 if sum(aaa)>0
                    pop2(:,de_position)=0;
                    pop2_value=decode(pop2,data,K,fold,label);
                 end
                 pop_value_m=repmat(pop_value,2,1);
                 pop_m=[pop1;pop2];
                 new_m=[pop1_value;pop2_value]; 
                 chazhi=new_m-pop_value_m;
                 label1=zeros(1,size(chazhi,1));
                 for k=1:size(chazhi,1)
                     chazhi_value=chazhi(k,:);
                     if (chazhi_value(1)<0)&(chazhi_value(2)<0)
                         label1(1,k)=1;
                     elseif (chazhi_value(1)<0)&(chazhi_value(2)==0)
                         label1(1,k)=1;
                     elseif (chazhi_value(1)==0)&(chazhi_value(2)<0)
                         label1(1,k)=1;
                     else 
                           if (length(find(chazhi_value>0))==1)&(length(find(chazhi_value<0))==1)
                               EC=[EC;[new_m(k,:),pop_m(k,:)]];
                               label1(1,k)=2;
                           end
                     end  
                 end
                 if length(find(label1==1))>0  
                    aa=find(label1==1); 
                    if length(aa)>1
                        aa1=randperm(length(aa),1); 
                        aa_position=aa(aa1); 
                        newpopulation(i,:)=pop_m(aa_position,:);
                        fitvalue(i,:)=new_m(aa_position,:); 
                        bb=1:length(aa);
                        bb(aa1)=[];
                        for k=1:length(bb)
                            EC=[EC;[new_m(k,:),pop_m(k,:)]];
                        end
                    else
                        newpopulation(i,:)=pop_m(aa,:);
                        fitvalue(i,:)=new_m(aa,:); 
                    end
                 end 
             end
         end
end  