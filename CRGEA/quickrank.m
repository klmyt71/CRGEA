function [frontlabel]=quickrank(lastpopution,frontvalue)
lastpopution=[zeros((size(lastpopution,1)),1),lastpopution];
frontlabel=[];
ceng=0;
 while ~isempty(lastpopution)
      label=[];
      ceng=ceng+1;
    for i1=1:size(lastpopution,1)
        n=0;
        pnum=[];
        qnum=[];
        for j1=1:size(lastpopution,1)
               if i1==j1
                 continue;
               end
               chazhi=frontvalue(i1,:)-frontvalue(j1,:);
               chazhi(find(chazhi>-0.00001&chazhi<0.00001))=0;
               if ((chazhi(1)>0)&(chazhi(2)>0))||((chazhi(1)==0)&(chazhi(2)>0))||((chazhi(1)>0)&(chazhi(2)==0))   %%被别人支配
                   n=1;
                  break;
               end
               if  ((chazhi(1)<=0)&(chazhi(2)<0))||((chazhi(1)<0)&(chazhi(2)<=0))||((chazhi(1)<0)&(chazhi(2)>0))||((chazhi(1)>0)&(chazhi(2)<0))
                   plabel=j1;
                   pnum=[pnum; plabel];
               end
               if (chazhi(1)==0)&(chazhi(2)==0)  
                   qlabel=j1;  
                   qnum=[qnum;qlabel]; 
               end
        end
           pnum1=length(pnum); 
           qnum1=length(qnum);
           zonggeshu=pnum1+qnum1;
           if  (n==0)&(qnum1==0)
            lastpopution(i1,1)=ceng;
            label1=i1;
            label=[label;label1];
           end
            if  (n==0)&(zonggeshu==(size(lastpopution,1)-1))&(qnum1>0)
                  lastpopution(i1,1)=ceng;
                label1=i1;
                label=[label;label1];
            end
     end
            zhongjian1=lastpopution(label,:);
            frontlabel=[frontlabel;zhongjian1];
            lastpopution(label,:)=[];
            frontvalue=lastpopution(:,2:3);
 end