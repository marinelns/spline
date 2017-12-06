function [bk] = hermite(pk, mk)
    %calcule les 4 points de contrôle de l'interpolation pour un morceau
    %de la courbe
    bk = [0;0];
    bk(:, 1) = pk(:, 1)
    bk(:, 2) = pk(:, 1) + (1/3) * mk(:, 1);      
    bk(:, 3) = pk(:, 2) - (1/3) * mk(:, 2);       
    bk(:, 4) = pk(:, 2);
    bk;
end