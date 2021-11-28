clear;
close all;

load SG1.mat;
load ImSG1.mat;

X = Data(:);
Y = DataMod(:);

A = [X ones(length(X),1)*(-1)];
T = - log(Y);

 Beta_chapeau= pinv(A) * T;

I_cha = -1/Beta_chapeau(1)*(log(ImMod) - Beta_chapeau(2));

RMSE = sqrt(mean((I_cha(:) - I(:)).^2));

subplot(3,2,1)
imagesc(I);
axis off;
axis equal;
colormap gray;
title('Image originale');

subplot(3,2,2)
imagesc(ImMod);
axis off;
axis equal;
colormap gray;
title('Image modifiée');

subplot(3,1,3)
imagesc(I_cha);
axis off;
axis equal;
colormap gray;
title('Image reconstituée');
