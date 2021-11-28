clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des canaux RVB','Position',[0,0,0.67*L,0.67*H]);
figure('Name','Nuage de pixels dans le repere RVB','Position',[0.67*L,0,0.33*L,0.45*H]);

% Lecture et affichage d'une image RVB :
I = imread('ishihara-0.png');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

% Affichage du canal R :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(R);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(V);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(B);
axis off;
axis equal;
title('Canal B','FontSize',20);

% Affichage du nuage de pixels dans le repere RVB :
figure(2);				% Deuxieme fenetre d'affichage
plot3(R,V,B,'b.');
axis equal;
xlabel('R');
ylabel('V');
zlabel('B');
rotate3d;

% Matrice des donnees :
X = [R(:) V(:) B(:)];			% Les trois canaux sont vectorises et concatenes

% Matrice de variance/covariance :

n= length(X);
X_moy = 1/n*X'*ones(n,1);
X_c = X - ones(n,1)*X_moy';
sigma = 1/n*(X_c')*X_c;

% Coefficients de correlation lineaire :

rR = sigma(1,1);
rV = sigma(2,2);
rB = sigma(3,3);
rRV = sigma(1,2)/sqrt(sigma(1,1)*sigma(2,2));
rRB = sigma(1,3)/sqrt(sigma(1,1)*sigma(3,3));
rVB = sigma(2,3)/sqrt(sigma(2,2)*sigma(3,3));

% Proportions de contraste :
s = rR^2 + rV^2 + rB^2;
cR = rR^2/s;
cV = rV^2/s;
cB = rB^2/s;
fprintf("le coefficient de correlations rRV est %3f\n", rRV);
fprintf("le coefficient de correlations rRB est %3f\n", rRB);
fprintf("le coefficient de correlations rVB est %3f\n", rVB);

fprintf("la proportion de contraste dans le canal R est %3f\n" , cR);
fprintf("la proportion de contraste dans le canal V est %3f\n" , cV);
fprintf("la proportion de contraste dans le canal B est %3f\n" , cB);


[W,D] = eig(sigma);
Z = diag(D);
[Z_triee, ind] = sort(Z,'descend');

W_tri = W(:, ind);
C = X_c*W_tri;
Im = reshape(C,size(I));


I_R = double(Im(:,:,1));
I_V = double(Im(:,:,2));
I_B = double(Im(:,:,3));

% Affichage du canal R :
figure;
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(I_R);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(I_V);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(I_B);
axis off;
axis equal;
title('Canal B','FontSize',20);







