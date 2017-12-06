function [mk] = estimation(Pk)
    %estimation ne remplie "que" les tangentes interieures
    %les tangentes extremes sont calculees autrement
    mk = [0,0];
    N = size(Pk,2);
    for k=2 : N-1
        mk(:, k) = (Pk(:, k+1) - Pk(:, k-1))/2;
    end
    mk(:,N) = 0;
end