clear all
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

TEB_simule = [];
for indice =0:length(Eb_N0_db)-1 
    
     % Génération de l’information binaire
      bits = randi([0, 1], 1, nb_bits);
 
     %symbole de signal emis
       Symboles = 2*bits-1;
    
     %Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
       Suite_diracs=kron(Symboles, [1 zeros(1,Ns-1)]);
     %Filtrage de mise en forme
       signal_emis = filter(h,1,Suite_diracs);
    
    %canal et bruit
       % canal
       signal_canal = filter(hc,1,signal_emis);
%      %ajout du bruit
       Px = mean(abs(signal_canal).^2);
       sigma_carre= Px*Ns/(2*10^(Eb_N0_db(indice+1)/10));
       bruit = sqrt(sigma_carre)*randn(1,length(signal_canal));
       
       signal_recu = signal_canal+bruit;
       
  % filtrage de reception 
       signal_recu_filtre = filter(hr,1,signal_recu);
    % echantillonnage avec n0 = Ns
   signal_ech = signal_recu_filtre(Ns:Ns:end);
   
   % passage dans l'égaliseur:
   % réponse impulrionnelle de l'égaliseur
   heg = C.';
   signal_ech_eg = filter(heg,1,signal_ech);
   % decision:
   symboles_decides = sign(signal_ech_eg);
   % demapping:
   bits_recu = (symboles_decides+1)/2;
      
   % TEB

   TEB_simule = [TEB_simule length(find(bits_recu~=bits))/length(bits)];    
       
end
% tracé du TEB simulé:
figure;
semilogy(Eb_N0_db, TEB_simule);
xlabel('Eb/N0')
ylabel('TEB')
title('TEB simule')

% comparaison des tracés des TEB de la chaine étudiée et le TEB de la chaine complète sans égalisation: 
       % TEB théorique de la chaine complète sans egalisation
          TEB_canal_th = 0.5*qfunc(sqrt((2/5)*10.^(Eb_N0_db/10)))+0.5*qfunc(1.5*sqrt((8/5)*10.^(Eb_N0_db/10)));
       
  figure;
  semilogy(Eb_N0_db,TEB_simule,'g-*');
  hold on
  semilogy(Eb_N0_db,TEB_canal_th,'k-o');

  % semilogy(Eb_N0_db,TEB_th,'r-o');
  xlabel('Eb/N0')
  ylabel('TEB')
  legend('TEB avec égalisation','TEB sans égalisation')
  grid
  % comparaison des tracés des TEB de la chaine avec egalisation et le TEB de la chaine complète sans égalisation et la chaine sans canal: 
       % TEB théorique sur une chaine sans canal
              TEB_th = qfunc(sqrt(2*10.^(Eb_N0_db/10)));
       
  figure;
  semilogy(Eb_N0_db,TEB_simule,'g-*');
  hold on
  semilogy(Eb_N0_db,TEB_canal_th,'k-v');
  semilogy(Eb_N0_db,TEB_th,'r-o');
  xlabel('Eb/N0')
  ylabel('TEB')
  legend('TEB avec égalisation','TEB sans égalisation','TEB chaine AWGN')
  grid
  
  
  
  
    