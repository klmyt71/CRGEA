function outpopulation=feizhipei(population)
aaa=1:size(population,1);
lastpopulation=[aaa',population];
popuvalue=population(:,1:2);
population=population(:,3:end);
fzpweizhi_p=zeros(1,size(population,1));
for i=1:size(population,1)
    fzplabel=0;
    popuvalue1=popuvalue;
    for j=1:size(population,1)
        if i==j
            continue
        end
        chazhipopulation=popuvalue1(i,:)-popuvalue1(j,:);
        if chazhipopulation(1)<0.000000001&&chazhipopulation(1)>-0.000000001
            chazhipopulation(1)=0;
        end
        if chazhipopulation(2)<0.000000001&&chazhipopulation(2)>-0.000000001
            chazhipopulation(2)=0;
        end
        fzplabel2=length(find(chazhipopulation>=0));
        fzplabel3=length(find(chazhipopulation>0));
        fzplabel4=length(find(chazhipopulation==0));
        if fzplabel2==2&&(fzplabel3>=1)
           fzplabel=1;
           break
        end
        if fzplabel4==2&&(i<j)
           fzplabel=1;
           break
        end     
    end
       if fzplabel==0
           fzpweizhi_p(1,i)=1;
       end 
end
fzpweizhi_last_p=find(fzpweizhi_p==1)';
outpopulation=lastpopulation(fzpweizhi_last_p,:);   