function [point_aitken] = aitken(Pi, t)
   	n = size(Pi,2);
    poly_aitken = [0;0];
    for i = 1 : n
        poly_aitken(1,i) = Pi(1,i);
        poly_aitken(2,i) = Pi(2,i);
    end
    for k = 1:n-1
        for i = 1 : n-k
            poly_aitken(1,i) =((i+k-t)/k)*poly_aitken(1,i) + ((t-i)/k)*poly_aitken(1,i+1);
            poly_aitken(2,i) =((i+k-t)/k)*poly_aitken(2,i) + ((t-i)/k)*poly_aitken(2,i+1);
        end
    end
    point_aitken = poly_aitken(:,1)
end