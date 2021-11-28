function L = laplacian(nu,dx1,dx2,N1,N2)
%
%  Cette fonction construit la matrice de l'opérateur Laplacien 2D anisotrope
%
%  Inputs
%  ------
%
%  nu : nu=[nu1;nu2], coefficients de diffusivité dans les dierctions x1 et x2. 
%
%  dx1 : pas d'espace dans la direction x1.
%
%  dx2 : pas d'espace dans la direction x2.
%
%  N1 : nombre de points de grille dans la direction x1.
%
%  N2 : nombre de points de grilles dans la direction x2.
%
%  Outputs:
%  -------
%
%  L      : Matrice de l'opérateur Laplacien (dimension N1N2 x N1N2)
%
% 

% Initialisation
b1 = nu(1)/dx1^2;
b2 = nu(2)/dx2^2;
a = 2*(b1+b2);

A = spdiags(ones(N2,1)*[-b2 a -b2], -1:1, N2, N2);
D = spdiags(ones(N2,1)*(-b1), 0, N2, N2);

L = sparse([]);
    for i = 1:N1
       is = ( i - 1 ) * N2+1;
       ie = i * N2;
       L(is:ie,is:ie) = A;
       if ( i < N1 )
          L(is:ie,ie+1:ie+N2) = D;
          L(ie+1:ie+N2,is:ie) = D;
       end
    end
    is = ( N1 - 1 ) * N2 + 1;
end
