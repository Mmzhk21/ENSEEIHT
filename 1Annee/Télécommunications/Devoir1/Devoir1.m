%frequence d'echantillonnage 
Fe= 24000;
Te = 1/Fe;
Rb = 6000;
%Nombrede bits générés
nb_bits=4000;
%Génération de l’information binaire
bits=randi([0,1],1,nb_bits); 

%__________________________________________________________________________
%Modulateur1:
Rs1= Rb/log2(2);
Ns1 = Fe/Rs1;
Ts1 = Ns1*Te;
%Mapping binaire à moyenne nulle: 0->-1, 1->1
Symboles_1=2*bits-1;
%Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
Suite_diracs=kron(Symboles_1, [1 zeros(1,Ns1-1)]); 
%Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)
h=ones(1,Ns1);
%Filtrage de mise en forme
x1=filter(h,1,Suite_diracs);
%Affichage du signal généré
figure ; 
plot(x1);
title("modulateur 1")
axis([0 nb_bits-1 -1.5 1.5]);
%DSP
[PSDx1,f]=pwelch(x1,[],[],Fe,'twosided');
figure;
semilogy(f-Fe/2,fftshift(PSDx1));
hold on;
title("DSP modulateur 1")
% densité spectrale théorique:
f= linspace(-Fe/2,Fe/2,length(x1));
PSDx1_theorique = (1/Ts1)*(sinc(f*Ts1).^2);
semilogy(f-Fe/2,fftshift(PSDx1_theorique));
hold off;



%__________________________________________________________________________
% Modulateur2:


%Durée symbole en nombre d’échantillons (Ts=NsTe)
Rs2= Rb/log2(4);
Ns2 = Fe/Rs2;
Ts2 = Ns2*Te;
% Mapping 4-aires à moyenne nulle: 0->-1, 1->1
Symboles_2 = zeros(1,Ns2/2);
k=1;
for i=1:Ns2/2
    if bits(k)==0 &&  bits(k+1)==0
        Symboles_2(k) = -3;
    elseif bits(k)==0 &&  bits(k+1)==1
        Symboles_2(k) = -1;
    elseif bits(k)==1 &&  bits(k+1)==0
        Symboles_2(k) = 1;
    elseif bits(k)==1 && bits(k+1)==1
        Symboles_2(k) = 3;
    end
    k=k+2;
end
        
%Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
Suite_diracs=kron(Symboles_2, [1 zeros(1,Ns2-1)]); 
%Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)
h=ones(1,Ns2);
%Filtrage de mise en forme
x2=filter(h,1,Suite_diracs);
%Affichagedu signal généré
figure ; 
plot(x2);
title("modulateur 2")
axis([0 nb_bits-1 -1.5 1.5]);
%DSP
figure;

[PSDx2,f]=pwelch(x2,[],[],Fe,'twosided');
figure;
semilogy(f-Fe/2,fftshift(PSDx2));
hold on;
title("DSP modulateur 2")
% densite spectrale theorique
f= linspace(-Fe/2,Fe/2,length(x1));
PSDx2_theorique = Ts2*sinc(Ts2*f).^2;
semilogy(f-Fe/2,fftshift(PSDx2_theorique));
hold off;
%__________________________________________________________________________
%Modulateur3:
%Durée symbole en nombre d’échantillons (Ts=NsTe)
Rs3= Rb/log2(2);
Ns3 = Fe/Rs3;
Ts3 = Ns3*Te;
%Mapping binaire à moyenne nulle: 0->-1, 1->1
Symboles_3=2*bits-1;
%Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
Suite_diracs=kron(Symboles_3, [1 zeros(1,Ns3-1)]); 
%Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)
h=ones(1,Ns3);
for i=1:(Ns3/2)
    h(2*i) = -1;
end
%Filtrage de mise en forme
x3=filter(h,1,Suite_diracs);
%Affichage du signal généré
figure ; 
plot(x3);
title("modulateur 3")
%axis([0 nb_bits-1 -1.5 1.5]);
%DSP
[PSDx3,f]=pwelch(x3,[],[],Fe,'twosided');
figure;
semilogy(f-Fe/2,fftshift(PSDx3));
hold on;
title("DSP modulateur 3")
% DSP theorique
f= linspace(-Fe/2,Fe/2,length(x1));
PSDx3_theorique = (1/Ts3)*(((sin(pi*f*Ts3/2).^2)\(pi*f*Ts3/2)).^2);
semilogy(f-Fe/2,fftshift(PSDx3_theorique));
hold off;


%__________________________________________________________________________
% Modulateur 4:
%Durée symbole en nombre d’échantillons (Ts=NsTe)
Rs4= Rb/log2(2);
Ns4 = Fe/Rs4;
Ts4 = Ns4*Te;
alpha = 0.5;
%Mapping binaireà moyenne nulle: 0->-1, 1->1
Symboles_4=2*bits-1;
%Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
Suite_diracs=kron(Symboles_4, [1 zeros(1,Ns4-1)]); 
%Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)
h=rcosdesign(0.5,8,Ns4);
%Filtrage de mise en forme
x4=filter(h,1,Suite_diracs);
%Affichage du signal généré
figure ; 
plot(x4);
title("modulateur 4")
%axis([0 nb_bits-1 -1.5 1.5]);

%DSP

[PSDx4,f]=pwelch(x4,[],[],Fe,'twosided');
figure;
semilogy(f-Fe/2,fftshift(PSDx4));
hold on;
title("DSP modulateur 4")
% densite spectrale theorique
f= linspace(-Fe/2,Fe/2,length(x1));
PSDx4_theorique = zeros(length(f),1); %% Initialisation du vecteur densité spectral theorique de mapping 4
for i = 1:length(f)   %% Utilisons l'expression donnée dans le sujet 
    if abs(f(i)) <= (1 - alpha) / (2 * Ts4) 
        PSDx4_theorique(i) = Ts4;
    elseif (1 - alpha) / (2 * Ts4) <= abs(f(i)) <= (1 + alpha) / (2 * Ts4)
        PSDx4_theorique(i) = Ts4 / 2 * (1 + cos(pi * Ts4 / alpha * (abs(f(i)) - ((1 - alpha) / (2 * Ts4)))));
    else
        PSDx4_theorique(i) = 0;
    end 

end
semilogy(f-Fe/2,fftshift(PSDx4_theorique));
zoom on;

hold off;
[~,f]=pwelch(x4,[],[],Fe,'twosided');
% tracées du DSPs

 figure;
 
 semilogy(f-Fe/2,fftshift(PSDx1));
 hold on ;
 semilogy(f-Fe/2,fftshift(PSDx2));
 semilogy(f-Fe/2,fftshift(PSDx3));
 semilogy(f-Fe/2,fftshift(PSDx4));
 hold off;






