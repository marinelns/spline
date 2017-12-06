function [poly_bernstein]=bernstein(i,m,t)
    %calcule le polynome de Bernstein de degre m
    poly_bernstein = nchoosek(m,i)*(t^i)*(1-t)^(m-i);
end

