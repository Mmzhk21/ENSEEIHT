%%
    %   4    Deuxième chaine à  ́etudier, implanter et comparer à la chaine de référence
    
    % 4.2    Implantation de la chaine sans bruit
    %Durée symbole en nombre d’échantillons (Ts=NsTe)
    Rs= Rb/log2(4);
    Ns = Fe/Rs;

    %Mapping binaire à moyenne nulle: 0->-1, 1->1
     Symboles2=(2*bi2de(reshape(bits,2,length(bits)/2).')-3).';
   %Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
    Suite_diracs=kron(Symboles2, [1 zeros(1,Ns-1)]);

    %Filtrage de mise en forme
    x_filtre =filter(h1,1,Suite_diracs);
    
    
    %Filtrage de reception
    signal_recu2 = filter(hr1,1,x_filtre);   
    % 4 diangramme de l'oeil
    figure;
    plot(reshape(signal_recu2,Ns,length(signal_recu2)/Ns));  
    title(' diagramme de l’oeil pour la deuxième chaine sans bruit')
    xlabel("Temps en seconde")
    ylabel("Diagramme de l'oeil")

   % 6 Echantillonnage du signal en sortie du filtre de réception 

    n0 = Ns;
    signal1_ech = signal_recu1(Ns:Ns:end);
    
    %decision
    
    SymbolesDecides = zeros(1,Ns);
    for i=1:length(signal1_ech)
       if signal1_ech(i) <= -2*Ns
             SymbolesDecides(i) = -3;
       elseif signal1_ech(i) <0
             SymbolesDecides(i) = -1;
       elseif signal1_ech(i) > 2*Ns
             SymbolesDecides(i) = 3;
       elseif signal1_ech(i)>0
             SymbolesDecides(i) = 1;     
       end
   end
           
           
   % Demaping
         
     
     BitsDecides= reshape(de2bi((SymbolesDecides + 3)/2)',1,length(bits));
     
   % taux d'erreur
    er = length(find(BitsDecides ~= bits));
    
    TEB_3 = er/nb_bits;   % taux d'erreur pour la deuxième chaine sans bruit
    % Calcul de la DSP du signal par périodogramme
    DSP_3 =  (1 / length(signal_recu1)) * abs(fft(signal_recu1, 2 ^ nextpow2(length(signal_recu1)))) .^ 2;

    % Affichage de la DSP du signal transmis
    figure;
    plot(linspace(-1, 1, length(DSP_3)), fftshift(DSP_3));
    title('DSP du signal transmis pour la deuxieme chaine');
    xlabel('Fréquences en Hz');
    ylabel('S_{x}(f)');
    
  %comparaison entre les DSP de la chaine de référence et la deuxieme chaine
  
    figure;
    hold on;
    plot(linspace(0, 1, length(DSP_r)), fftshift(DSP_r),'r-');
    plot(linspace(0, 1, length(DSP_3)), fftshift(DSP_3),'b-');
    hold off;
    title('DSP de la chaine de réference et la deuxième chaine');
    legend('deuxième chaine', 'chaine de réference');
    xlabel('fréquence en Hz');
    ylabel('S_{x}(f)');
    
    %% 4.3    Implantation de la deuxième chaine avec bruit
    
    TES_bruit_4 = [];
    TEB_simule_4 = [];
    for i = 1:length(Eb_N0_dB)

        Px = mean(abs(x_filtre).^2);
        sigma_carre = (Px*Ns)/(2*2*(10 ^ (Eb_N0_dB(i)/10)));
        bruit = sqrt(sigma_carre)*randn(1,length(x_filtre));
        r3 = x_filtre + bruit;

       %Filtrage de reception
       signal_recu1 = filter(hr1,1,r3);
    
        signal1_ech = signal_recu1(Ns:Ns:end);
    
    %decision
    
    SymbolesDecides = zeros(1,Ns);
    for j=1:length(signal1_ech)
       if signal1_ech(j) <= -2*Ns
             SymbolesDecides(j) = -3;
       elseif signal1_ech(j) <0
             SymbolesDecides(j) = -1;
       elseif signal1_ech(j) > 2*Ns
             SymbolesDecides(j) = 3;
       elseif signal1_ech(j)>0
             SymbolesDecides(j) = 1;     
       end
    end
     % Calcul TES
            nb_erreur = length(find(Symboles2~=SymbolesDecides));
            TES_b = nb_erreur/length(Symboles2);
            TES_bruit_4 = [TES_bruit_4, TES_b];
     % Calcul TEB
            TEB_b =TES_b/2;
            TEB_simule_4 = [TEB_simule_4, TEB_b];
    end  
    % Tracé du taux d’erreur symbolique en fonction de Eb/N0
    figure(6);
    semilogy(Eb_N0_dB, TES_bruit_4, 'r-');
    title('Figure : Taux d''erreur symbolique de la deuxieme chaine');
    xlabel('Eb/N0 (dB)');
    ylabel('TES');
    
    
   
    % TES théorique
    TES_th_4 = (3/2)*qfunc(sqrt((4 / 5) * 10 .^ (Eb_N0_dB / 10)));
    
    % Comparaison du TES simulé et TES théorique
    hold on;
    semilogy(Eb_N0_dB, TES_th_4, 'g-*');
    legend('TES simulé','TES théorique');
    
    % taux d’erreur binaire (TEB) obtenu en fonction du rapport signal à bruit
    TEB_simule_4 = TES_th_4/2;
    figure;
    semilogy(Eb_N0_dB, TEB_simule_4, 'r*');
    title('TEB pour la deuxieme chaine ')
    
    % comparaison du TEB theorique au TEB obtenu par simulation
        figure;
        semilogy(Eb_N0_dB, TEB_simule_4, 'r*');
        title('Figure : TEB de la deuxieme chaine');
        xlabel('Eb/N0 (dB)');
        ylabel('TEB');
        
        hold on;
        
        semilogy(Eb_N0_dB, TES_th_4/2, 'b-*');
        legend('TEB simulé','TEB théorique');
        
   % 5.Comparer  le  TEB  obtenu  par  simulation  sur  la  chaine
   % implantée  au  TEB  obtenu  pour  la  chaine  de ref erence
       figure;
        semilogy(Eb_N0_dB, TEB_simule_4, 'r-');
        title('comparaison de TEB de la deuxieme chaine et la chaine de reference');
        xlabel('Eb/N0 (dB)');
        ylabel('TEB');
        
        hold on;
        semilogy(Eb_N0_dB, TEB_bruit_1,'b-');
        legend('TEB chaine 2', 'TEB chaine de reference')