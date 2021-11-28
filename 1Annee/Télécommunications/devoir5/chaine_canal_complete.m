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
  retard = Ns/2;
% valeurs de Eb/N0
  Eb_N0_db= [0:10];

%Génération de la réponse impulsionnelle du filtre de mise en forme
    h = ones(1,Ns);
%Génération de la réponse impulsionnelle du filtre de réception
    hr = fliplr(h);
%Génération de la réponse impulsionnelle du canal
    hc = kron([1 0.5], [1 zeros(1, Ns-1)]);
    
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
       %signal_emis = filter(h,1,[Suite_diracs zeros(1,retard)]);
    
    %supprimer le retard ajouté avant le filtrage
       %signal_emis = signal_emis(retard + 1 : end);
  %canal et bruit
       % canal
       signal_canal = filter(hc,1,signal_emis);
%        signal_canal = filter(hc,1,[signal_emis zeros(1,retard)]);
%        signal_canal = signal_canal(retard+1:end);
       %ajout du bruit
       Px = mean(abs(signal_canal).^2);
       sigma_carre= Px*Ns/(2*10^(Eb_N0_db(indice+1)/10));
       bruit = sqrt(sigma_carre)*randn(1,length(signal_canal));
       
       signal_recu = signal_canal+bruit;
       
  % filtrage de reception 
       signal_recu_filtre = filter(hr,1,signal_recu);
       %signal_recu_filtre = filter(hr,1,[signal_recu zeros(1,retard)]);
       %signal_recu_filtre = signal_recu_filtre(retard+1:end);
   % echantillonnage avec n0 = Ns
   signal_ech = signal_recu_filtre(Ns:Ns:end);
   % decision:
   symboles_decides = sign(signal_ech);
   % bits recu
   bits_recu = (symboles_decides+1)/2;
      
   % TEB

   TEB_simule = [TEB_simule length(find(bits_recu~=bits))/length(bits)];    
       
end


% TEB théorique sur une chaine avec un canal
TEB_canal_th = 0.5*qfunc(sqrt((2/5)*10.^(Eb_N0_db/10)))+0.5*qfunc(1.5*sqrt((8/5)*10.^(Eb_N0_db/10)));

      
% comparaison des tracés des TEB theorique et simulé       
       
       figure;
       semilogy(Eb_N0_db,TEB_simule,'g-*');
       hold on
       semilogy(Eb_N0_db,TEB_canal_th,'r-');
       
      % semilogy(Eb_N0_db,TEB_th,'r-o');
       xlabel('Eb/N0')
       ylabel('TEB')
       legend('TEB théorique','TEB simulé')
       grid
       
 % comparaison des tracés des TEB de la chaine étudiée et le TEB de la chaine AWGN: 
       % TEB théorique sur une chaine sans canal
              TEB_th = qfunc(sqrt(2*10.^(Eb_N0_db/10)));
       
              figure;
              semilogy(Eb_N0_db,TEB_th,'g-*');
              hold on
              semilogy(Eb_N0_db,TEB_canal_th,'k-o');
       
              % semilogy(Eb_N0_db,TEB_th,'r-o');
              xlabel('Eb/N0')
              ylabel('TEB')
              legend('TEB chaine AWGN','TEB chaine avec canal')
              grid
