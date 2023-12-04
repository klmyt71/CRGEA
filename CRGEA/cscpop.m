function [pop,CR]=cscpop(pop,b,su_m)
    limit_m=[0.50,0.65,0.80];
    c_num=floor(pop*0.8/3);  
    c_num_pop1=rand(c_num,b); 
    c_num_pop2=rand(c_num,b); 
    c_num_pop3=rand(c_num,b); 
    c_v=su_m(:,end)';  
    hu_m=su_m(:,1:b);  
    max_m=max(su_m);
    su_m=su_m./max_m;    
    c_v_p=c_v./max(c_v); 
    r_v=(sum(hu_m,2)./(b-1))';  
    r_v_p=r_v./max(r_v);
    cr_v=[c_v_p;r_v_p];
    min_cr_v=min(cr_v);
    max_cr_v=max(cr_v);
    min_max=(min_cr_v./max_cr_v)*0.3;
    CR=c_v_p-min_max;
    CR=CR./max(CR);  
    aaa=CR>c_num_pop1; 
    bbb=CR>limit_m(1);
    pop_11=aaa&bbb;
    aaa=CR>c_num_pop2; 
    bbb=CR>limit_m(2);
    pop_22=aaa&bbb;
    aaa=CR>c_num_pop3; 
    bbb=CR>limit_m(3);
    pop_33=aaa&bbb;
    pop_1=[pop_11;pop_22;pop_33]; 
    c_num_pop1=rand(pop-c_num*3,b);
    pop_2=double(c_num_pop1>0.5);  
    pop=[pop_1;pop_2];
    pop_sum=sum(pop,2);
    pop_popsi=find(pop_sum==0);
    if length(pop_popsi)>0
       pop(pop_popsi,randperm(b,1))=1;
    end