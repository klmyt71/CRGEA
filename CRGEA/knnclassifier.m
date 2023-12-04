function accur = knnclassifier(traindata, testdata, K)
    dist = zeros(size(traindata, 1), 1);
    expclass=zeros(1,size(testdata,1));
    for i = 1 : size(testdata)
        x = testdata(i,:);
        for j = 2 : size(traindata, 2)  
            dist(:, 1) =  dist(:, 1) + (traindata(:, j) - x(j)) .^ 2;
        end
        dist(:, 1) = sqrt(dist(:, 1));
        classes = traindata(:, 1);
        dist(:, 2) = classes;
        poll = sortrows(dist, 1);
        if (mod(K, 2) == 1)
            expclass(i) = mode(poll(1 : K, 2));
        else
            temp = poll(1 : K, 2);
            uniq = unique(temp);
            p = size(uniq);
            bincounts = histc(temp, uniq);
            q = max(bincounts);
            M = (p == 2) & (q == K/2);
            expclass(i) = mode(poll(1 : K - M, 2));    
        end
    end
    error = transpose(expclass) - testdata(:, 1);
    accur = ((size(error, 1) - nnz(error))/size(error, 1));
