%3.1    Etude sans canal de propagation :  bloc modulateur/d ́emodulateur

%modulateur 


%frequence d'echantillonnage 
Fe= 24000;
Te = 1/Fe;
Rb = 6000;
Eb_N0_dB = (0:1:8);

%Nombre de bits générés
nb_bits=4000;

%Génération de l’information binaire à transmettre
bits=randi([0,1],1,nb_bits); 

%Durée symbole en nombre d’échantillons (Ts=NsTe)
Rs= Rb/log2(2);
Ns = Fe/Rs;

%Mapping binaire à moyenne nulle: 0->-1, 1->1
Symboles=2*bits-1;

%Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
Suite_diracs=kron(Symboles, [1 zeros(1,Ns-1)]);

%Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)

h1=ones(1,Ns);

%Filtrage de mise en forme
x_filtre =filter(h1,1,Suite_diracs); 

% Démodulateur

%Génération de la réponse impulsionnelle du filtre de réception
hr1 = fliplr(h1);


%Filtrage de réception
signal_recu1 = filter(hr1,1,x_filtre);   

% 4 diangramme de l'oeil
figure(1);
plot(reshape(signal_recu1,Ns,length(signal_recu1)/Ns));  
title(' diagramme de l’oeil pour la chaine de reference sans bruit')

% Calcul de la DSP du signal par périodogramme
DSP_r = (1 / length(signal_recu1)) * abs(fft(signal_recu1, 2 ^ nextpow2(length(signal_recu1)))) .^ 2;

% Affichage de la DSP du signal transmis
figure(2);
plot(linspace(-1, 1, length(DSP_r)), fftshift(DSP_r));
title('DSP du signal transmis pour la chaine de réference');
xlabel('Fréquences en Hz');
ylabel('S_{x}(f)');

% 6 Echantillonnage du signal en sortie du filtre de réception 

    n0 = Ns;
    signal1_ech = signal_recu1(n0:Ns:end);
    
   % Demaping
     bits_recu = (1 + sign(signal1_ech))/2;
     
   % taux d'erreur
    er = length(find(bits_recu ~= bits));
    
    TEB_R = er/nb_bits;   % taux d'erreur pour la chaine de référence
    
%% chaine avec bruit
 
TEB_bruit_1 = [];
for i=1:length(Eb_N0_dB)
    % ajout du bruit

    Px = mean(abs(x_filtre).^2);
    sigma_carre = (Px*Ns)/(2*10^(Eb_N0_dB(i)/10));
    bruit = sqrt(sigma_carre)*randn(1,length(x_filtre));
    r1 = x_filtre + bruit;

    %Filtrage de reception
    signal_recu1 = filter(hr1,1,r1);   
    
% 6 Echantillonnage du signal en sortie du filtre de réception 

    n0 = Ns;
    signal1_ech = signal_recu1(n0:Ns:end);
    
   % Demaping
     bits_recu = (1 + sign(signal1_ech))/2;
     
   % TEB simulé pour la chaine de réference avec bruit
    er = length(find(bits_recu ~= bits));
    
    
    TEB_bruit_1 = [TEB_bruit_1, er/nb_bits];
end

% 4 diangramme de l'oeil
figure;
plot(reshape(signal_recu1,Ns,length(signal_recu1)/Ns));  
title(' diagramme de l’oeil pour la chaine de reference avec bruit pour Eb_N0_db = 8')
xlabel("Temps en seconde")
ylabel("Diagramme de l'oeil")



    % 2 Tracé du taux d’erreur binaire obtenu  en  fonction  du  rapport  signal  à  bruit  par  bit  `a  l’entr ́ee  du récepteur (Eb/N0) en décibels
    figure(2);
    semilogy(Eb_N0_dB, TEB_bruit_1);
    title('Figure 5 : obtenu  en  fonction de Eb/N0 pour la chaine de référence avec bruit');
    xlabel('Eb/N0 (dB)');
    ylabel('TEB');
  
    % 3 comparaison des Tracés  des  taux  d’erreur  binaire simulé et théorique  
       % tracé du TEB simulé
         figure(3);
         semilogy(Eb_N0_dB, TEB_bruit_1,'r-');
         title("Comparaison entre le TEB simulé et TEB théorique")
         xlabel('Eb/N0 (dB)');
         ylabel('TEB');
       % TEB théorique
       
        TEB_th = (1/2)*erfc(sqrt(10 .^ (Eb_N0_dB / 10))/sqrt(2));
        hold on;
        semilogy(10*log10(Eb_N0_dB),TEB_th,'g-');
        legend('TEB simulé','TEB théorique');