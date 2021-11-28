clear;
close all;

load SG2.mat;
load ImSG2.mat;

X = Data(:);
Y = DataMod(:);

A = [X ones(length(X),1)*(-1)];
B = - log(Y);

[U,S,V] = svd([A B]);

Beta_chapeau = - V(1:end-1,end)/V(end,end);

I_rec = -1/Beta_chapeau(1)*(log(ImMod) - Beta_chapeau(2));

RMSE = sqrt(mean((I_rec(:) - I(:)).^2));

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
imagesc(I_rec);
axis off;
axis equal;
colormap gray;
title('Image reconstituée');
