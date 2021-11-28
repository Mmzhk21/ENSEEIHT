clear all;
close all
%Débit binaire
Rb = 3000;
%fréquence d'échantillonnage
Fe = 24000;
%période d'échantillonnage
Te = 1/Fe;
%Temps symbole
Ns=Fe/Rb;
% nb_bits
nb_bits = 10000;
%retard
  retard = floor(Ns/3);
% valeurs de Eb/N0
  Eb_N0_db= [0:10];

%Génération de la réponse impulsionnelle du filtre de mise en forme
    h = ones(1,Ns);
%Génération de la réponse impulsionnelle du filtre de réception
    hr = fliplr(h);
%Génération de la réponse impulsionnelle du canal
    hc = kron([1 0.5], [1 zeros(1, Ns-1)]);
% dirac à envoyer:
diracs= [1 zeros(1,1000)];
%Filtrage de mise en forme
       signal_emis = filter(h,1,diracs);
% canal
       signal_recu = filter(hc,1,signal_emis);
% passage par le fitre de reception
     signal_recu_filte = filter(hr,1,signal_recu);
%Echantillonnage
    signal_ech = signal_recu_filte(Ns:Ns:end);
% calcul des coeffucients de l'égaliseur: 
N = 10;
Z = toeplitz(signal_ech(1:N), [signal_ech(1) zeros(1, length(signal_ech(1:N))-1)]);
C = ((Z)^(-1))*[1 zeros(1, size(Z,2)-1)].';

% Tracé de la réponse en fréquence du canal de propagation
   Hc = fft(hc);
   figure;
   plot(linspace(-Fe/2,Fe/2,length(Hc)),Hc);
   title("réponse frequentielle du canal");
   xlabel("fréquence en Hz") ; 
   ylabel("H(f)");      

% Tracé de la réponse en fréquence de l'égaliseur:
   heg = C.';
   Heg = fft(heg);
   
   figure;
   plot(linspace(-Fe/2,Fe/2,length(Heg)),Heg);
   title("réponse frequentielle de l'égaliseur");
   xlabel("fréquence en Hz"); 
   ylabel("He(f)"); 
% tracé du produit des deux réponses en fréquence:
  P = conv(hc,heg,'same');
  figure;
   plot(linspace(-Fe/2,Fe/2,length(fft(P))),fft(P));
   title("produit des réponses en frequentielle");
   xlabel("fréquence en Hz"); 
   ylabel("He(f)");

% Tracé de la réponse impultionnelle de la chaine sans et avec egalisation:
 g_non_egalise = conv(h,conv(hc,hr,'same'),'same');
 figure(9);
 plot(g_non_egalise);
 title('la réponse impultionnelle de la chaine sans égalisation')
 
 g_egalise = conv(g_non_egalise, heg,'same');
 figure(10);
 plot(g_egalise);
 title('la réponse impultionnelle de la chaine avec égalisation')
 
 
 %% Transmission d'une d'une information:
 % Génération de l’information binaire
      bits = randi([0, 1], 1, nb_bits);
 
     %symbole de signal emis
       Symboles = 2*bits-1;
    
     %Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
       Suite_diracs1=kron(Symboles, [1 zeros(1,Ns-1)]);
     %Filtrage de mise en forme
       signal_emis1 = filter(h,1,Suite_diracs1);
       
     % filtrage de reception 
       signal_recu_filtre1 = filter(hr,1,signal_emis1);
    % echantillonnage avec n0 = Ns
   signal_ech1 = signal_recu_filtre1(Ns:Ns:end);
   
     % passage dans l'égaliseur:
   % réponse impulrionnelle de l'égaliseur
   heg = C.';
   signal_ech_eg1 = filter(heg,1,signal_ech1);
   % decision:
   symboles_decides1 = sign(signal_ech_eg1);
   % demapping:
   bits_recu1 = (symboles_decides1+1)/2;
   % TEB
   TEB_1 = length(find(bits_recu1~=bits))/length(bits);
   
  % comparaison des constellations avant et aprés égalisation:
     
    
    scatterplot(signal_ech1);
    title('Les constellations avant l''égaliseur')
    
    scatterplot(signal_ech_eg1);
    title('Les constellations après l''égaliseur')










