function [mk] = estimation(Pk)
    mk = [0,0];
    N = size(Pk,2);
    for k=3 : N-2
        mk(1, k) = (Pk(1, k+1) - Pk(1, k-1))/2;
        mk(2, k) = (Pk(2, k+1) - Pk(2, k-1))/2;
    end
    %Calcul aux extrémités à l'aide des points rentrés à la souris
    mk(1, 2) = Pk(1, 1) - Pk(1, 2);
    mk(2, 2) = Pk(2, 1) - Pk(2, 2);
    mk(1, N-1) = Pk(1, N) - Pk(1, N-1);
    mk(2, N-1) = Pk(2, N) - Pk(2, N-1);
end