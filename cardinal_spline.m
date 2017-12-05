function [mk] = cardinal_spline(Pk, c)
    %cardinal spline ne remplie "que" les tangentes interieures
    %les tangentes extremes sont calculees autrement
    mk = [0,0];
    N = size(Pk, 2);
    for k = 2 : N - 1
        mk(1, k) = (1-c)*(Pk(1,k+1) - Pk(1,k));
        mk(2, k) = (1-c)*(Pk(2,k+1) - Pk(2,k));
    end
    mk(N,1) = 0;
    mk(N,2) = 0;
end