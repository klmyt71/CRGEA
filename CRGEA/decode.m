function  fitvalue=decode(population,data,K,fold,label)
    pop=size(population,1);
    fitvalue1=zeros(pop,2);
    for w=1:pop
        data11=data;
        curr=population(w,:);
        curr_s=find(curr==1);
        data1=data11(:,curr_s);
        A=[label,data1];
        nrows = size(A, 1);   
        s=zeros(1,fold);
        for chunk = 1 : fold
            X = A;
            randrows=1:nrows;
            chunksize = floor(nrows/fold);   
            x = (chunk - 1) * chunksize + 1;
            y = chunk * chunksize;
            testdata = X(randrows(x:y), :); 
            if chunk == 1
               traindata = X(randrows(y + 1:end), :);
            elseif chunk == fold
                   traindata = X(randrows(1 : x-1), :);
            else
               pop=[randrows(1:x-1),randrows(y+1:end)];
               traindata = X(randrows(pop), :);
            end
               currentacc = knnclassifier(traindata, testdata, K);
               s(1,chunk) = 1-currentacc;   
        end
        fitvalue1(w,:)=[mean(s),length(curr_s)];
    end
    fitvalue=fitvalue1;