%Etude avec canal de propagation sans bruit
%modulateur %%%%%%%


%frequence d'echantillonnage 
Fe= 24000;
Te = 1/Fe;
Rb = 3000;
%Nombrede bits générés
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
h2 =rcosdesign(0.5,12,Ns);
%Filtrage de mise en forme
x_filtre1 =filter(h1,1,Suite_diracs);
x_filtre2 =filter(h2,1,Suite_diracs);

N = 39;
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



% Demodulateur

% 2.0.6    Filtrage de réception
hr1 = ones(1,Ns);
hr2 = rcosdesign(0.5,12,Ns);

%Filtrage
signal_recu1 = filter(hr1,1,r1);
signal_recu2 = filter(hr2,1,r2);



% 4 diangramme de l'oeil
figure;
plot(reshape(signal_recu1,Ns,length(signal_recu1)/Ns));   
title(" diagramme de l'oeil pour la chaine 1 et BW 4000 HZ"); 

figure;
plot(reshape(signal_recu2,Ns,length(signal_recu2)/Ns)); 
title(" diagramme de l'oeil pour la chaine 2 et BW 4000 HZ");


%%    2 
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



% Demodulateur

%%2.0.6    Filtrage de réception
hr1 = ones(1,Ns);
hr2 = rcosdesign(0.5,8,Ns);

%Filtrage
signal_recu1 = filter(hr1,1,r1);
signal_recu2 = filter(hr2,1,r2);



% 4 diangramme de l'oeil
figure;
plot(reshape(signal_recu1,Ns,length(signal_recu1)/Ns));   
title(" diagramme de l'oeil pour la chaine 1 et BW 1000 HZ");
figure;
plot(reshape(signal_recu2,Ns,length(signal_recu2)/Ns)); 
title(" diagramme de l'oeil pour la chaine 2 et BW 1000 HZ");



