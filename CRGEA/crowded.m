function [distancevalue,popu]=crowded(frontlabel,fnum)
        popu=find(frontlabel(:,1)==fnum+1);                        
        functionvalue=frontlabel(:,2:3);
        distancevalue=zeros(size(popu));       
        fmax=max(frontlabel(:,2:3),[],1);                      
        fmin=min(frontlabel(:,2:3),[],1);                         
        for l=1:2     
            [a,newsite]=sortrows(functionvalue(popu,l));
            distancevalue(newsite(1))=inf;
            distancevalue(newsite(end))=inf;
            for m=2:length(popu)-1
                distancevalue(newsite(m))=distancevalue(newsite(m))+(functionvalue(popu(newsite(m+1)),l)-functionvalue(popu(newsite(m-1)),l))/(fmax(l)-fmin(l));
            end
        end