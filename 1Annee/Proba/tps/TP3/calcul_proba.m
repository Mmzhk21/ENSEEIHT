function [x_min,x_max,probabilite] = calcul_proba(E_nouveau_repere,p)
       x_min = min(E_nouveau_repere(:, 1));
       x_max = max(E_nouveau_repere(:, 1));
       y_min = min(E_nouveau_repere(:, 2));
       y_max = max(E_nouveau_repere(:, 2));
       N = round((x_max - x_min)*(y_max - y_min));
       n = length(E_nouveau_repere);
       probabilite = 1 - binocdf(n-1, N, p);
end