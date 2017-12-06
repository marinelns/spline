function [poly_aitken] = aitken(Pi, t)
   	n = size(Pi,2);
    for i = 1 : n+1
        poly_aitken(i,:) = Pi(i,:);
    end
    for k = 1:n
        for i = 1 : n-k+1
            poly_aitken(i-1,:) =((i+k-1-t)/k)*P(i-1,:) + ((t-i-1)/k)*P(i,:);
        end
    end
end