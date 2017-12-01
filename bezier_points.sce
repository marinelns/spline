function [bezier_points] = decasteljau(mat, res)
    T = mat;
    n = size(T,2) - 1;
    for (t = 1: res)
        T = mat;
        for (i = 1: n)
            for (j = 1 : n-i+1)
                T(1, i, j) = ((t-1)/res)*T(1, i+1, j) + ((1-((t-1)/res))*T(1, i, j));
                T(2, i, j) = ((t-1)/res)*T(2, i+1, j) + ((1-((t-1)/res))*T(2, i, j));
            end
        end
        bezier_points(1,t) = T(1,1);
        bezier_points(2,t) = T(2,1);
    end
endfunction

A = [1, 2, 3; 4, 5, 6];
a = decasteljau(A, 50);
print(a);
