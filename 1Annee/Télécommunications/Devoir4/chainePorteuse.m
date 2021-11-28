
%%  Implantation de la chaine sur fŕequence porteuse
Rb = 2000;
Fe = 10000;
Te = 1/Fe;
alpha = 0.35;
fp = 2000;
fc = 1700;
%SPAN
    span = 8;
%Rs
Rs = 1000;
%Temps symbole
Ns=Fe/Rs;
% nb_bits
nb_bits = 10000;
% E/N0
Eb_N0_db = (0:8);
%retard
  retard = span*Ns/2;
% ordre du filtre 
N = 50;
  
% Génération de l’information binaire
bits = randi([0, 1], 1, nb_bits);


%Symboles de I et Q
    SymbolesI=2*randi([0, 1], 1, nb_bits)-1;
    SymbolesQ= 2*randi([0, 1], 1, nb_bits)-1 ;
    
%symbole de signal emis
    Symboles = SymbolesI+ 1i*SymbolesQ;
    
%Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
Suite_diracsI=kron(SymbolesI, [1 zeros(1,Ns-1)]);
Suite_diracsQ=kron(SymbolesQ, [1 zeros(1,Ns-1)]);

%Génération de la réponse impulsionnelle du filtre de mise en forme
    h = rcosdesign(alpha,span,Ns);
    hr = fliplr(h);
    h_passe_bas = 2*(fc/Fe)*sinc(2*(fc/Fe)*[-N:N]);
    
%Filtrage de mise en forme    
    I = filter(h,1,[Suite_diracsI zeros(1,retard)]);
    Q = filter(h,1,[Suite_diracsQ zeros(1,retard)]);
    
%supprimer le retard ajouté avant le filtrage
    I = I(retard + 1 : end);
    Q = Q(retard + 1 : end);
    
% (1) - Affichage des signaux générés sur les voies en phase et en quadrature
figure(1);
plot(I)
axis([0 length(I) -1 1])
title("Signal généré sur la voie en phase")
xlabel('Temps en secondes');
ylabel("I(t)")

figure(2);
plot(Q)
axis([0 length(Q) -1 1])
title("Signal généré sur la voie en quadrature")
xlabel('Temps en secondes');
ylabel("Q(t)")

% Le signal transmis sur fréquence porteuse
temps = 0:Te:(length(I)-1)*Te;
X = I.*cos(2*pi*fp*temps) - Q.*sin(2*pi*fp*temps);

% (1) - Affichage du signal transmis sur la fréquence porteuse.
figure(3);
plot(X)
axis([0 nb_bits -1 1])
title("Signal transmis sur la fréquence porteuse")
ylabel("Signal transmis")


%2)% Affichage de la DSP du signal émis
figure;
DSP=(1/length(X))*abs(fft(X,2^nextpow2(length(X)))).^2;
plot(linspace(-Fe / 2, Fe / 2, length(DSP)), fftshift(DSP));
% plot(linspace(0,100,length(DSP)),fftshift(DSP));
title('DSP du signal émis sur la chaine porteuse');
ylabel('DSP');
xlabel('fréquence en Hz');

% Diagramme de l'oeil
diag_oeil = reshape(I,2*Ns,length(I)/(2*Ns));
figure;
plot(diag_oeil);
title('Diagramme d''oeil');
ylabel('x');
xlabel('temps en s');


%1-Retour en bande de base
x1_retour = X.*cos(2*pi*fp*temps);
x2_retour = X.*sin(2*pi*fp*temps);
Xr = x1_retour - 1i*x2_retour;

x_filtre = conv(Xr,h_passe_bas,'same');


%Passage par filtre de réception
    xi_r = filter(hr,1,[x_filtre zeros(1,retard)]);
    xi_r = xi_r(retard +1:end);

%Echantillonnage
    xi_ech = xi_r(1:Ns:end);
    
%Demapping
    Symboles_Decides = zeros(1,length(xi_ech));

    for k=1:length(xi_ech)
        if (real(xi_ech(k)) <= 0 && imag(xi_ech(k)) <= 0)
            Symboles_Decides(k) = -1 - 1i;

        elseif (real(xi_ech(k)) >= 0 && imag(xi_ech(k)) >= 0)
            Symboles_Decides(k) = 1 + 1i;

        elseif (real(xi_ech(k)) <= 0 && imag(xi_ech(k)) >= 0)
            Symboles_Decides(k) = -1 + 1i;

        elseif (real(xi_ech(k)) >= 0 && imag(xi_ech(k)) <= 0)
            Symboles_Decides(k) = 1 - 1i;
        end
    end
    
% TEB

   TEB_1 = length(find(Symboles_Decides~=Symboles))/(2*length(Symboles));
  
   %%  %Implantation de la chaine avec bruit
   TEB_fp = zeros(1,9);
   for j=1:length(Eb_N0_db)
       
       % ajout du bruit
        Px = mean(abs(X).^2);
        gn_carre = (Px*Ns)/(4*(10^(Eb_N0_db(j)/10)));
        nI = sqrt(gn_carre)*randn(1,length(X));
        x_bruit = X + nI;
        
        signal_bruite_I = x_bruit.*cos(2*pi*fp*temps);
        signal_bruite_Q = 1i*x_bruit.*sin(2*pi*fp*temps);
        signal_bruite_1 = signal_bruite_I - signal_bruite_Q;
        
%         signal_bruite_1 = conv(signal_bruite_1, h_passe_bas, 'same');
%         signal_bruite_1 = signal_bruite_1(N+1: end);
        signal_conv  = filter(hr,1,[signal_bruite_1 zeros(1,retard)]);
        signal_recu = signal_conv(retard+1:end);
        %échantillonnage du signal à T=Ns, le pas= Ns
        signal_echantillonne = signal_recu(1:Ns:end);
        
        symboles_decides = zeros(1,length(signal_echantillonne));
        
    for k=1:length(signal_echantillonne)
        if (real(signal_echantillonne(k)) <= 0 && imag(signal_echantillonne(k)) <= 0)
            symboles_decides(k) = -1 - 1i;

        elseif (real(signal_echantillonne(k)) >= 0 && imag(signal_echantillonne(k)) >= 0)
            symboles_decides(k) = 1 + 1i;

        elseif (real(signal_echantillonne(k)) <= 0 && imag(signal_echantillonne(k)) >= 0)
            symboles_decides(k) = -1 + 1i;

        elseif (real(signal_echantillonne(k)) >= 0 && imag(signal_echantillonne(k)) <= 0)
            symboles_decides(k) = 1 - 1i;
        end
    end
    TEB_fp(j)= length(find(symboles_decides~=Symboles))/(2*length(Symboles));
    
   end
   figure;
semilogy(Eb_N0_db,TEB_fp,'r-o');
xlabel('E_b/N_0 en décibels');
ylabel('TEB');
title({'le taux d erreur binaire';' du chaine sur fréquence porteuse'});
        
  %5)Comparaison entre TEB simulé et TEB théorique
    
    Teb_theorique = qfunc(sqrt(2*(10.^(Eb_N0_db/10))));    
    figure;
    semilogy(Eb_N0_db,TEB_fp,'r-o');
    hold on;
    semilogy(Eb_N0_db,Teb_theorique,'b-*');
    
    %tracé le taux d'erreur binaire obtenu en fonction du rapport signal à bruit par bit à l'entrée du récepteur (Eb/N0) en décibels.
    legend('TEB simulé','TEB theorique');
    xlabel('E_b/N_0 en décibels');
    ylabel('TEB');
    title({'Comparaison du TEB_{theorique} et TEB_{estimé}';' du chaine sur fréquence porteuse'});

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
   
   


