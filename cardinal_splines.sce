function [mk] = cardinal_spline(Pk, c)
    mk = 0;
    N = size(Pk, 2);
    for (k = 1 : N - 1)
        mk(1, k) = (1-c)*(Pk(1,k+1) - Pk(1,k));
        mk(2, k) = (1-c)*(Pk(2,k+1) - Pk(2,k));
    end
endfunction
