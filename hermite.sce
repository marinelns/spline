function [hermite_points] = hermite(Pk, c, choix_estimation, resolution)
    mk = 0;
    N = size(Pk, 2)
    
    if (choix_estimation == 1) then   //si on utilise notre estimation (cf Q3)
        mk = estimation(Pk);
    else   // si on utilise cardinal splines
        mk = cardinal_splines(Pk, c);
    end
    
    for (i = 2: N-1)
        point(1, 1) = Pk(1, i);
        point(2, 1) = Pk(2, i);
        
        point(1, 2) = Pk(1, i) + (1/3) * mk(1, i);
        point(2, 2) = Pk(1, i) + (1/3) * mk(2, i);
        
        point(1, 3) = Pk(1, i+1) - (1/3) * mk(1, i+1);
        point(2, 3) = Pk(2, i+1) - (1/3) * mk(2, i+1);
        
        point(1, 4) = Pk(1, i+1);
        point(2, 4) = Pk(2, i+1);

        hermite_points = [hermite_points decasteljau(point, res)];
    end
endfunction
