close all
clear all
%%  Implantation de la chaine sur fŕequence porteuse

%Débit binaire
Rb = 3000;
%fréquence d'échantillonnage
Fe = 24000;

%Temps symbole
Ns=Fe/Rb;
% nb_bits
nb_bits = 10000;
%retard
  retard = Ns/2;
% valeurs de Eb/N0
  Eb_N0_db= [0:10];
% Génération de l’information binaire
bits = randi([0, 1], 1, nb_bits);
 
%symbole de signal emis
    Symboles = 2*bits-1;
    
%Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
Suite_diracs=kron(Symboles, [1 zeros(1,Ns-1)]);
%Génération de la réponse impulsionnelle du filtre de mise en forme
    h = ones(1,Ns);
%Génération de la réponse impulsionnelle du filtre de réception
    hr = fliplr(h);
    
    
%Filtrage de mise en forme    
    signal_filtre = filter(h,1,[Suite_diracs zeros(1,retard)]);
    
%supprimer le retard ajouté avant le filtrage
    signal_filtre = signal_filtre(retard + 1 : end);
 
% (1) - Affichage du signal transmis
figure(3);
plot(signal_filtre)
axis([0 nb_bits -1 1])
title("Signal transmis")



%2)% Affichage de la DSP du signal émis
figure;
DSP=(1/length(signal_filtre))*abs(fft(signal_filtre,2^nextpow2(length(signal_filtre)))).^2;
plot(linspace(-Fe / 2, Fe / 2, length(DSP)), fftshift(DSP));
% plot(linspace(0,100,length(DSP)),fftshift(DSP));
title('DSP du signal émis sur la chaine sans canal');
ylabel('DSP');
xlabel('fréquence en Hz');



%Passage par filtre de réception
    signal_recu0 = filter(hr,1,[signal_filtre zeros(1,retard)]);
    signal_recu0 = signal_recu0(retard +1:end);
    
% Diagramme de l'oeil
% diag_oeil = reshape(signal_recu0,2*Ns,length(signal_recu0)/(2*Ns));
% figure;
% plot(diag_oeil);
% title('Diagramme d''oeil');
% ylabel('x');
% xlabel('temps en s');
%Echantillonnage
    signal_ech0 = signal_recu0(1:Ns:end);
    
    
%Demapping
    Symboles_Decides = (1+sign(signal_ech0))/2;

    
    
% TEB

   TEB = length(find(Symboles_Decides~=bits))/length(bits);
   
   
   
   %% canal sans bruit
   hc = kron([1 0.5], [1 zeros(1, Ns-1)]);
   
   Ye = filter(hc,1,signal_filtre);
   
   
   %Passage par filtre de réception
    signal_recu1 = filter(hr,1,[Ye zeros(1,retard)]);
    signal_recu1 = signal_recu1(retard +1:end);
    
    % le signal en sortie du filre de reception
    figure;
    plot(signal_recu1);
    title('signal en sortie du filre de reception');
    ylabel('signal filtré');
    xlabel('temps en s');
    
    
%Echantillonnage
    signal_ech1 = signal_recu1(Ns:Ns:end);
    
    
    figure;
    hist(signal_ech1, 100);
%Demapping
    Symboles_Decides1 = (1+sign(signal_ech1))/2;

    
    
% TEB

   TEB_1 = length(find(Symboles_Decides1~=bits))/length(bits);

    
    
    
    
    
    
    
    
    
    
    
   