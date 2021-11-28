function [C_x,C_y,M] = matrice_inertie(E_x,E_y,G_norme_E)
          pi = sum (G_norme_E);
          C_x = (1/pi)*(E_x'*G_norme_E);
          C_y = (1/pi)*(E_y'*G_norme_E);
          M(1, 1) = (1/pi)*((E_x-C_x).^2)'*G_norme_E;
          M(2, 2) = (1/pi)*((E_y-C_y).^2)'*G_norme_E;
          M(1, 2) = (1/pi)*((E_x-C_x).*(E_y-C_y))'*G_norme_E;
          M(2, 1) = M(1, 2);
end
