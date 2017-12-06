function [poly_aitken] = aitken(Pi, ti, t)
   	n = size(Pi,2);
    for i = 1 : n+1
        poly_aitken(i,:) = Pi(i,:);
    end
    for k = 1:n
        for i = 1 : n-k+1
            poly_aitken(i-1,:) = ((ti(i+k-1)-t)/(ti(i+k-1)-t(i-1)))*P(i-1,:) + ((t-ti(i-1))/(t(i+k-1)-ti(i)))*P(i,:);
        end
    end
end