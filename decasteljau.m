function [Bezier_points] = decasteljau(mat, res)
    T = mat;
    n = size(T,2) - 1; %degre de courbes avec n+1 points de controle
    temps = 1 : res;
    Bezier_points = [0,0];
    for t = temps
        T = mat;
        for i = 1: n
            for j = 1 : n-i+1
                T(1, i) = (t/res)*(T(1, i+1)) + (1-(t/res))*(T(1, i));
                T(2, i) = (t/res)*(T(2, i+1)) + (1-(t/res))*(T(2, i));
            end
        end
        Bezier_points(1,t) = T(1,1);
        Bezier_points(2,t) = T(2,1);
    end
end