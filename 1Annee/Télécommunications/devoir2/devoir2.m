%3.1    Etude sans canal de propagation :  bloc modulateur/d ́emodulateur

%modulateur %%%%%%%


%frequence d'echantillonnage 
Fe= 24000;
Te = 1/Fe;
Rb = 3000;

%Nombrede bits générés
nb_bits=3000;

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

h1=ones(1,Ns);   % pour la première chaine
h2 =rcosdesign(0.5,12,Ns);   % pour la Deuxième chaine

figure;
plot(h2);
title(' la réponse impulsionnelle du filtre de mise en forme pour la Deuxième chaine')

%Filtrage de mise en forme
x_filtre1 =filter(h1,1,Suite_diracs);  % la première chaine
x_filtre2 =filter(h2,1,Suite_diracs);  % la Deuxième chaine


% Démodulateur

%%2.0.6    Filtrage de réception
hr1 = ones(1,Ns);
hr2 = rcosdesign(0.5,12,Ns);

%Filtrage
signal_recu1 = filter(hr1,1,x_filtre1);   % la première chaine
signal_recu2 = filter(hr2,1,x_filtre2);   % la Deuxième chaine



%2.0.9    Demapping
%signal_recu = (g+ones(1,Ns))/2;


g1 = conv(h1,hr1);
g2 = conv(h2,hr2);
figure;
plot(g1);    % la première chaine
title('la foction g pour la première chaine ')
figure;
plot(g2);
title('la foction g pour la deuxième chaine')


    
% 4 diangramme de l'oeil
figure;
plot(reshape(signal_recu1,Ns,length(signal_recu1)/Ns));  
title(' diagramme de l’oeil pour la première chaine (sans canal)')

figure;
plot(reshape(signal_recu2,Ns,length(signal_recu2)/Ns)); 
title(' diagramme de l’oeil pour la première chaine (sans canal)')

% 5 : l’instant n 0 optimal est 1

% 6 Echantillonnage du signal en sortie du filtre de réception 

    n0 = 1;
    signal1_ech = signal_recu1(n0:Ns:end);
    signal2_ech = signal_recu2(n0:Ns:end);
   % Demaping
     bits_recu1 = (1 + sign(signal1_ech))/2;
     bits_recu2 = (1 + sign(signal2_ech))/2;
   % taux d'erreur
    er1 = length(find(bits_recu1 ~= bits));
    er2 = length(find(bits_recu2 ~= bits));
    
    tr11 = er1/nb_bits;   % taux d'erreur pour la première chaine avec n0 = 1
    tr12 = er2/nb_bits;   % taux d'erreur pour la deuxième chaine avec n0 = 1
    
%7.  Echantillonnez le signal en sortie du filtre de reception à n0+mNs, avec n0= 3
    % n0 = 3 pour la première chaine
    n01 = 3; 
    % n0 = 6 pour la première chaine
    n02= 6;
     signal1_ech = signal_recu1(n01:Ns:end);
     signal2_ech = signal_recu2(n02:Ns:end);
   % Demaping
     bits_recu1 = (1 + sign(signal1_ech))/2;
     bits_recu2 = (1 + sign(signal2_ech))/2;
   % taux d'erreur
    er1 = length(find(bits_recu1 ~= bits));
    er2 = length(find(bits_recu2 ~= bits));
    
    tr31 = er1/nb_bits;   % taux d'erreur pour la première chaine avec n0 = 3
    tr32 = er2/nb_bits;   % taux d'erreur pour la deuxième chaine avec n0 = 6
    
  %%  
%% Etude avec canal de propagation sans bruit
  %%

  %% 1: fc = 4000;
    % La réponse impulsionnelle d’un filtre passe-bas représentant le canal de propagation
       N = 51;
       fc = 4000;
       hc = (2*fc/Fe)*sinc(2*fc*(-(N-1)*Te/2 :Te: (N-1)*Te/2)*1/pi);
       Nfft = 2048;
       Y = fft(hc,Nfft);
       Z = abs(fft(conv(h1,hr1,'same')));
       figure;
       plot(linspace(-Fe/2,Fe/2,length(Z)),Z);
       title("|H(f)Hr(f)| et |Hc(f)| pour la chaine 1 et Bw = 4000")
       hold on;
       plot(linspace(-Fe/2,Fe/2,length(Y)),abs(Y));
       hold off;

r1 = conv(x_filtre1,hc,'same');
r2 = conv(x_filtre1,hc,'same');



%Filtrage de reception
signal_recu1 = filter(hr1,1,r1);
signal_recu2 = filter(hr2,1,r2);



% 4 diangramme de l'oeil pour fc = 4000;
figure;
plot(reshape(signal_recu1,Ns,length(signal_recu1)/Ns));   
title(" diagramme de l'oeil pour la chaine 1 et BW= 4000HZ (avec canal)"); 

figure;
plot(reshape(signal_recu2,Ns,length(signal_recu2)/Ns)); 
title(" diagramme de l'oeil pour la chaine 2 et BW=4000HZ (avec canal)");

%%%%%%%%%%%
%%    2 : fc = 1000;
fc = 1000;
hc = (2*fc/Fe)*sinc(2*fc*(-(N-1)*Te/2 :Te: (N-1)*Te/2)*1/pi);

Y = fft(hc);
Z = abs(fft(conv(h1,hr1,'same')));
figure;
plot(linspace(-Fe/2,Fe/2,length(Z)),Z);
title("|H(f)Hr(f)| et |Hc(f)| pour la chaine 1 et Bw = 1000")
hold on;
plot(linspace(-Fe/2,Fe/2,length(Y)),abs(Y));
hold off;

r1 = conv(x_filtre1,hc,'same');
r2 = conv(x_filtre1,hc,'same');



% Filtrage de reception
signal_recu1 = filter(hr1,1,r1);
signal_recu2 = filter(hr2,1,r2);



% 4 diangramme de l'oeil pour fc = 1000;
figure;
plot(reshape(signal_recu1,Ns,length(signal_recu1)/Ns));   
title(" diagramme de l'oeil pour la chaine 1 et BW=1000HZ (avec canal)");
figure;
plot(reshape(signal_recu2,Ns,length(signal_recu2)/Ns)); 
title(" diagramme de l'oeil pour la chaine 2 et BW=1000HZ (avec canal)");

 
        
        
        
