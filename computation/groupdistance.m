function result = groupdistance(vector, vectorset, distype, a)

    dim = size(vectorset, 1);
    n1 = size(vector, 2);
    n2 = size(vectorset, 2);
    result = zeros(n1, n2);
    
    if strcmp(distype, 'euclidean') || strcmp(distype, 'euclid')
        
        if nargin < 4, a = ones(1,dim); end
        
        if n1 == 1
            result = sqrt( a * ( bsxfun(@minus, vectorset, vector) .^ 2 ) );
        else
            for i = 1:n1
                result(i,:) = sqrt( a * ( bsxfun(@minus, vectorset, vector(:,i)) .^ 2 ) );
            end
        end
        
    elseif strcmp(distype, 'correlation') || strcmp(distype, 'corr')
        
        vector = bsxfun(@minus, vector, mean(vector,1));
        vector = bsxfun(@rdivide, vector, std(vector,[],1));
        
        if nargin == 4
            vector = vector .* a;
        end
        
        vectorset = bsxfun(@minus, vectorset, mean(vectorset,1));
        vectorset = bsxfun(@rdivide, vectorset, std(vectorset,[],1));
        result = vector' * vectorset / (dim-1);
        
    elseif strcmp(distype, 'gauss')
        
        K = zeros(n1+n2);
        O = ones(n1+n2) / (n1+n2);
        
        for i = 1:n1
            for j = i:n1
                K(i,j) = exp(-norm(vector(:,i) - vector(:,j))^2);
                K(j,i) = K(i,j);
            end
        end
        for i = 1:n1
            for j = 1:n2
                K(i,n1+j) = exp(-norm(vector(:,i) - vectorset(:,j))^2);
                K(n1+j,i) = K(i,n1+j);
            end
        end
        for i = 1:n2
            for j = i:n2
                K(n1+i,n1+j) = exp(-norm(vectorset(:,i) - vectorset(:,j))^2);
                K(n1+j,n1+i) = K(n1+i,n1+j);
            end
        end
        
        K = K - O*K - K*O + O*K*O;
        result = K(1:n1,(n1+1):(n1+n2));
        
    elseif strcmp(distype, 'poly')
        
        K = ([vector vectorset]' * [vector vectorset] + 1).^2;
        O = ones(n1+n2) / (n1+n2);
        
        K = K - O*K - K*O + O*K*O;
        result = K(1:n1,(n1+1):(n1+n2));
        
    end
    
end