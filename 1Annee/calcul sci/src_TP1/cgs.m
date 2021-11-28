%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% cgs.m
%--------------------------------------------------------------------------

function Q = cgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    
    %------------------------------------------------
    Q(:,1) = A(:,1)/norm(A(:,1));
    for i = 2:m
        y = A(:,i);
        for j = 1:i-1
            Q(:,i) = Q(:,i)- Q(:,j)*y'*Q(:,j);
        end
        Q(:,i) = Q(:,i)/norm(Q(:,i));
    end 
    %------------------------------------------------

end