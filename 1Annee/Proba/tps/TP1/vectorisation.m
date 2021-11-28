function [X,Y] = vectorisation(I)
   nb_colonnes = size(I , 2);
   I_gauche = I(:, 1:nb_colonnes - 1);
   X = I_gauche(:);
   I_droite = I(: , 2: end);
   Y = I_droite(:);
end