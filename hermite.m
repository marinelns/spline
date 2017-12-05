function [Hermite_points] = hermite(Pk, c, choix_estimation, res)
    mk = 0;
    N = size(Pk, 2);
    
    if (choix_estimation == 1)   %si on utilise notre estimation (cf Q3)
        mk = estimation(Pk);
    else   %si on utilise cardinal splines
        mk = cardinal_spline(Pk, c);
    end
    
    for i = 2: N-2
        point(1, 1) = Pk(1, i);
        point(2, 1) = Pk(2, i);
        
        point(1, 2) = Pk(1, i) + (1/3) * mk(1, i);
        point(2, 2) = Pk(1, i) + (1/3) * mk(2, i);
        
        point(1, 3) = Pk(1, i+1) - (1/3) * mk(1, i+1);
        point(2, 3) = Pk(2, i+1) - (1/3) * mk(2, i+1);
        
        point(1, 4) = Pk(1, i+1);
        point(2, 4) = Pk(2, i+1);

        if i==2
            Hermite_points = decasteljau(point, res);
        else
            Hermite_points = [Hermite_points decasteljau(point,res)]
        end
    end
end