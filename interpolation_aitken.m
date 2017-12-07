function [pts_aitken] = interpolation_aitken(Pi, resolution)
    n = size(Pi,2);
    pts_aitken = [];
    for i = 1:n-1
        for j = 1:resolution
            pts_aitken = [pts_aitken aitken(Pi,i+j/resolution)];
        end
    end
end