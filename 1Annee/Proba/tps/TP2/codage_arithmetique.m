function [borne_inf, borne_sup] = codage_arithmetique(texte, selection_alphabet, bornes)
    borne_sup = 1;
    for i = 1:length(texte)
        j = find(selection_alphabet == texte(i));
        largeur = borne_sup-borne_inf;
        borne_sup = borne_inf+largeur*bornes(j,2);
        borne_inf = borne_inf+largeur*bornes(j,1);
    end
end