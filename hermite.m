function [bk] = hermite(pk, mk)
    %calcule les 4 points de contrôle de l'interpolation pour un morceau
    %de la courbe
    bk = [0;0]
    bk(1, 1) = Pk(1, 1);
    bk(2, 1) = Pk(2, 1);
        
    bk(1, 2) = Pk(1, 1) + (1/3) * mk(1, 1) 
    bk(2, 2) = Pk(1, 1) + (1/3) * mk(2, 1);
        
    bk(1, 3) = Pk(1, 1+1) - (1/3) * mk(1, 1+1);
    bk(2, 3) = Pk(2, 1+1) - (1/3) * mk(2, 1+1);
        
    bk(1, 4) = Pk(1, 1+1);
    bk(2, 4) = Pk(2, 1+1);
end