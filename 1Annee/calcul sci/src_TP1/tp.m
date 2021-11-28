%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% tp.m
%--------------------------------------------------------------------------

clear
close all
clc

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

%% Calcul de la perte d'orthogonalite

% Rang de la matrice
n = 4;

% Puissance de 10 maximale pour le conditionnement
k = 16;

% Matrice U de test
U = gallery('orthog',n);

% Matrice de reference
D = eye(n);

% Initialisation de la matrice pour recuperer les pertes d'orthogonalite
po = zeros(4,k);

for i = 1:k
  
  % Conditionnement de la matrice A
  %TO DO: modifier D pour obtenir A tel K(A)=10^k
  D(1,1) = 10^i;
  A = U*D*U';
  
  % Perte d'orthogonalite avec algorithme classique
  Qcgs = cgs(A);
  po(1,i) = norm(eye(n)-Qcgs'*Qcgs);
  Qcgs_2 = cgs(Qcgs);
  po(2,i) = norm(eye(n)-Qcgs_2'*Qcgs_2);
  
  % Perte d'orthogonalite avec algorithme modifie
  Qmgs = mgs(A);
  po(3,i) = norm(eye(n)-Qmgs'*Qmgs);
  Qmgs_2 = mgs(Qmgs);
  po(4,i) = norm(eye(n)-Qmgs_2'*Qmgs_2);
  
end

%% Affichage des courbes d'erreur

x = 10.^(1:k);

figure('Position',[0.1*L,0.1*H,0.8*L,0.75*H])

    loglog(x,po(1,:),'r','lineWidth',2)
    hold on
    loglog(x,po(2,:),'y','lineWidth',2)
    hold on
    loglog(x,po(3,:),'b','lineWidth',2)
    hold on
    loglog(x,po(4,:),'g','lineWidth',2)
    grid on
    leg = legend('Gram-Schmidt classique',...
                 'Gram-Schmidt classique iteré deux fois',... 
                 'Gram-Schmidt modifie',...
                 'Gram-Schmidt modifie iteré deux fois',...
                 'Location','NorthWest');
    set(leg,'FontSize',14);
    xlim([x(1) x(end)])
    hx = xlabel('\textbf{Conditionnement $\mathbf{\kappa(A_k)}$}',...
                'FontSize',14,'FontWeight','bold');
    set(hx,'Interpreter','Latex')
    hy = ylabel('$\mathbf{|| I - Q_k^\top Q_k ||}$','FontSize',14,'FontWeight','bold');
    set(hy,'Interpreter','Latex')
    title('Evolution de la perte d''orthogonalite en fonction du conditionnement',...
          'FontSize',20)


