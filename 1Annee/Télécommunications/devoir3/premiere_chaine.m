%% étude de la première chaine sans bruit

    hr2 = zeros(1,Ns);
    hr2(1:Ns/2) = ones(1,Ns/2);
    
    signal_recu2 = filter(hr2,1,x_filtre);
    
    % 4 diangramme de l'oeil
    figure(4);
    plot(reshape(signal_recu2,2*Ns,length(signal_recu2)/(2*Ns)));  
    title(' diagramme de l’oeil pour la première chaine sans bruit')
    xlabel("Temps en seconde")
    ylabel("Diagramme de l'oeil")

    % 6 Echantillonnage du signal en sortie du filtre de réception 

      n0 = Ns;
      signal2_ech = signal_recu2(n0:Ns:end);
    
    % Demaping
      bits_recu2 = (1 + sign(signal2_ech))/2;
     
    % taux d'erreur
     er = length(find(bits_recu2 ~= bits));
    
     TEB_1 = er/nb_bits;   % TEB pour la première chaine sans bruit
     
    % Calcul de la DSP du signal par périodogramme
    DSP_1 = (1 / length(signal_recu2)) * abs(fft(signal_recu2, 2 ^ nextpow2(length(signal_recu2)))) .^ 2;

    %Calcul de la DSP de la chaine de réference
    
    %DSP_r = (1 / length(signal_recu1)) * abs(fft(signal_recu1, 2 ^ nextpow2(length(signal_recu1)))) .^ 2;

    % Affichage de la DSP du signal généré
    figure;
    hold on;
    plot(linspace(-1, 1, length(DSP_1)), fftshift(DSP_r));
    plot(linspace(-1, 1, length(DSP_1)), fftshift(DSP_1));
    hold off;
    title('DSP du signal transmis pour la chaine de réference et la premiere chaine');
    legend('chaine de réference', 'premiere chaine');
    xlabel('Fréquence en Hz');
    ylabel('S_{x}(f)');
    
    %% Implantation de la première chaine avec bruit
    TEB_bruit_2 = [];
    for i=1:length(Eb_N0_dB)
        % ajout du bruit
        Px = mean(abs(x_filtre).^2);
        sigma_carre = (Px*Ns)/(10.^(Eb_N0_dB(i)/10));
        bruit = sqrt(sigma_carre)*randn(1,length(x_filtre));
        r2 = x_filtre + bruit;

       %Filtrage de reception
       signal_recu1 = filter(hr2,1,r2);   
    
    % 6 Echantillonnage du signal en sortie du filtre de réception 

    n0 = Ns;
    signal1_ech = signal_recu1(n0:Ns:end);
   % Demaping
     bits_recu = (1 + sign(signal1_ech))/2;
   % taux d'erreur
    er = length(find(bits_recu ~= bits));
    TEB_bruit_2 = [TEB_bruit_2 er/nb_bits];   % TEB pour la première chaine avec bruit
    end
    %     % 4 diangramme de l'oeil
    figure;
    plot(reshape(signal_recu1,Ns,length(signal_recu1)/Ns));  
    title(' diagramme de l’oeil pour la première chaine avec bruit pour Eb_N0_db = 8db')

    
    % Tracé du taux d’erreur binaire obtenu  en  fonction  du  rapport  signal  à  bruit  par  bit  `a  l’entr ́ee  du récepteur (Eb/N0) en décibels
    figure;
    semilogy(Eb_N0_dB, TEB_bruit_2);
    title('TEB obtenu  en  fonction de Eb/N0 pour la premiere chaine avec bruit');
    xlabel('Eb/N0 (dB)');
    ylabel('TEB');
  
    % 3 comparaison des Tracés  des  taux  d’erreur  binaire simulé et théorique  
       % tracé du TEB simulé
         figure(6);
         semilogy(Eb_N0_dB, TEB_bruit_2,'r-');
         title("Comparaison entre le TEB simulé et TEB théorique pour la premiere chaine")
         xlabel('Eb/N0 (dB)');
         ylabel('TEB');
       % TEB théorique
       
        TEB_th = (1/2)*erfc(sqrt(10.^(Eb_N0_dB/10))/sqrt(2));
        hold on;
        semilogy(Eb_N0_dB,TEB_th,'g-');
        legend('TEB simulé','TEB théorique');
    
        % Question 4 :
    % Comparaison du TEB simulé pour la chaine de transmission 
    % et TEB théorique de la chaine de référence
    figure(9);
    semilogy(Eb_N0_dB, TEB_bruit_2, 'r-');hold on;
    semilogy(Eb_N0_dB, TEB_th, 'b-');
    title('Taux d''erreur binaire de la chaine de reference et la premiere chaine');
    xlabel('Eb/N0 (dB)');
    ylabel('TEB');
    legend('TEB premiere chaine ','TEB chaine de reference');
    