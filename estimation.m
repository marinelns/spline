function [mk] = estimation(Pk)
    %estimation ne remplie "que" les tangentes interieures
    %les tangentes extremes sont calculees autrement
    mk = [0,0];
    N = size(Pk,2);
    for k=2 : N-1
        mk(1, k) = (Pk(1, k+1) - Pk(1, k-1))/2;
        mk(2, k) = (Pk(2, k+1) - Pk(2, k-1))/2;
    end
    mk(1,N) = 0;
    mk(2,N) = 0;
end