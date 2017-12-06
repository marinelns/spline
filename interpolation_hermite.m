
function [points_interpol] = interpolation_hermite(bk,resolution)
    %calcule les points de l'interpolation d'hermite sur un morceau
    % defini par ses pts de control
    points_interpol = [0;0];
    for j = 1:resolution
        s = 0;
        for i = 1:4
            s = s + bk(:,i)*bernstein(i-1,3,(j-1)/resolution);
        end
        points_interpol(:,j) = s;
    end
end