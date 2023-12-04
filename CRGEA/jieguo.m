function [data_LL,time_LL]=jieguo(data_input,su_m,shuliang)
data_L=cell(1,shuliang);
time_L=cell(1,shuliang);
for w=1:shuliang
    tic;
        data1=data_input;     %needs to be normalised, distance needs to be calculated
        su_m1=su_m;
        max_v=max(data1(:,2:end));
        data1(:, 2:end)=data1(:, 2:end)./max_v;
        label=data1(:,1); %data label
        data=data1(:,2:end);  
        [~,b]=size(data);  %b denotes the number of features
        pop=60;   %population size
        iter=200;   %Number of iterations
        Pc=0.9;      %crossover probability
        Pm=0.2;     %mutation probability
        Ts=10; %initial temperature 
        Rate=0.7;  %cooling rate
        Tc=3; %Number of cycles per temperature
        Tmin=1;   %final temperature
        K=3;   
        fold=5;
        %initialisation
        [population,CR]=cscpop(pop,b,su_m1); 
        % decode
        fitvalue=decode(population,data,K,fold,label);
        for i=1:iter
            i
            EC=[];  
            %cross
            [newpopulation,EC,fitvalue]=cross(population,fitvalue,EC,b,data,label,K,fold,Pc,b);
            %mutation 
            [newpopulation,EC,fitvalue]=mutation(newpopulation,data,label,Pm,fitvalue,EC,K,fold,CR);            
            lastpopulation=[fitvalue,newpopulation];
            on_inferior=feizhipei(lastpopulation); 
            popsition=on_inferior(:,1);
            %local search
            [newpopulation1,EC,fitvalue1]=localsearch(on_inferior(:,2:end),data,K,fold,label,Ts,Rate,Tc,Tmin,EC,CR);
            lastpopulation(popsition,:)=[fitvalue1,newpopulation1];
            lastpopulation1=[lastpopulation;EC];
            frontlabel=quickrank(lastpopulation1,lastpopulation1(:,1:2));
            if (length(find(frontlabel(:,1)==1)))<pop
                  fnum=0;                                                             
                  while numel(frontlabel(:,1),frontlabel(:,1)<=fnum+1)<pop        
                      fnum=fnum+1;
                  end
                  newnum=numel(frontlabel(:,1),frontlabel(:,1)<=fnum);             
                  population=zeros(size(population));
                  population(1:newnum,:)=frontlabel(1:newnum,4:end); 
                  fitvalue=frontlabel(1:newnum,2:3);
                  [distancevalue,popu]=crowded(frontlabel,fnum);
                  [~,newsite1]=sortrows(distancevalue);
                  newsite1=flip(newsite1);
                  newsite1=newsite1(1:pop-newnum);
                  population(newnum+1:pop,:)=frontlabel(popu(newsite1),4:end); 
                  fitvalue(newnum+1:pop,:)=frontlabel(popu(newsite1),2:3); 
             else
                  fnum=0;
                  population=zeros(size(population));
                  fitvalue=zeros(size(population,1),2);
                  [distancevalue,popu]=crowded(frontlabel,fnum);
                  [~,newsite11]=sortrows(distancevalue);
                  newsite1=flip(newsite11');
                  newsite1=newsite1(1:pop);
                  population(1:pop,:)=frontlabel(popu(newsite1),4:end); 
                  fitvalue(1:pop,:)=frontlabel(popu(newsite1),2:3); 
            end
            vpa(min(on_inferior(:,2:3)),3);
        end
        data_L{1,w}=on_inferior(:,2:end);
        toc
        time_L{1,w}=toc;
end
    data_LL=data_L;
    time_LL=time_L;
