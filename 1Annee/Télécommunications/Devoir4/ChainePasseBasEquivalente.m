
%% 3.2    Implantation de la chaine passe-bas  ́equivalente
     Rb = 2000;
    Fe = 10000;
    Te = 1/Fe;
    alpha = 0.35;
    fp = 2000;
    
    %Rs
    Rs = 1000;
    %Temps symbole
    Ts=1/Rs;
    %Ns
    Ns = Fe / Rs;
    % nb_bits
    nb_bits = 10000;
    % E/N0
    Eb_N0_db = (0:8);
    %retard
      retard=4*Ns;

    % Génération de l’information binaire
    bits = randi([0, 1], 1, nb_bits);


    %Symboles de I et Q
        SymbolesI=2*randi([0, 1], 1, nb_bits)-1;
        SymbolesQ= 2*randi([0, 1], 1, nb_bits)-1 ;

    %symbole de signal emis
        Symboles = SymbolesI+ 1i*SymbolesQ;

    %Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
    Suite_diracs=kron(Symboles, [1 zeros(1,Ns-1)]);
    %Génération de la réponse impulsionnelle du filtre de mise en forme
        h = rcosdesign(alpha/2,8,Ns);
        hr = fliplr(h);
        h_passe_bas = ones(1,8);
    %Filtrage de mise en forme    
        Xe = filter(h,1,[Suite_diracs zeros(1,retard)]);
    %supprimer le retard ajouté avant le filtrage
    Xe = Xe(retard + 1 : end);
    temps = [0 : length(Xe) - 1] * Te;
    % (1) - Affichage des signaux générés sur les voies en phase et en quadrature
    figure(1);
    xe_reel = real(Xe);
    plot(xe_reel)
    axis([0 length(Xe) -1 1])
    title("Signal généré sur la voie en phase")
    ylabel("I(t)")
    figure(2);
    xe_imag = imag(Xe);
    plot(xe_imag)
    axis([0 length(Xe) -1 1])
    title("Signal généré sur la voie en quadrature")
    ylabel("Q(t)")

    
    
    %2)%Affichage de la DSP du signal émis
    figure;
    DSP_pb=(1/length(Xe))*abs(fft(Xe,2^nextpow2(length(Xe)))).^2;
    plot(linspace(0,100,length(DSP_pb)),fftshift(DSP_pb));
    title('DSP du signal émis sur la chaine passe-bas équivalente');
    ylabel('DSP');
    xlabel('fréquence en Hz');

    % Diagramme de l'oeil
    oeil = reshape(xe_reel,2*Ns,length(Xe)/(2*Ns));
    figure;
    plot(oeil);
    title('Diagramme d''oeil');
    ylabel('x');
    xlabel('temps en s');

    %Passage par filtre de réception
    xi_r = filter(hr,1,[Xe zeros(1,retard)]);
    xi_r = xi_r(4*Ns +1:end);

%Echantillonnage
    xi_ech = xi_r(1:Ns:end);
    
%Demapping
    bits_recu_i = zeros(1,nb_bits);
    symboles_ai_r = sign(real(xi_ech));
    symboles_bi_r = sign(imag(xi_ech)); 
    Symbole_Decides = symboles_ai_r + 1i*symboles_bi_r;

    
% TEB

   TES_2 = length(find(Symbole_Decides~=Symboles))/length(Symboles);
   TEB_2 = TES_2/2;

%-------------------------------------------------------------
 %% ajout du bruit
 TEB_pb = [];
 for j=1:length(Eb_N0_db)
       
       % ajout du bruit
        Px = mean(abs(real(Xe)).^2);
        gn_carre = (Px*Ns)/(4*(10^(Eb_N0_db(j)/10)));
        nI = sqrt(gn_carre)*randn(1,length(Xe));
        ne = nI + 1i*nI;
        x_bruit = Xe + ne;
        
        signal_conv  = filter(hr,1,[x_bruit zeros(1,retard)]);
        signal_recu = signal_conv(retard+1:end);
        %échantillonnage du signal à T=Ns, le pas= Ns
        signal_echantillonne = signal_recu(1:Ns:end);
        
        symboles_decides = zeros(1,length(signal_echantillonne));
    for k=1:length(signal_echantillonne)
        if (real(signal_echantillonne(k)) <= 0 && imag(signal_echantillonne(k)) <= 0)
            symboles_decides(k) = -1 - 1i;

        elseif (real(signal_echantillonne(k)) >= 0 && imag(signal_echantillonne(k)) >= 0)
            symboles_decides(k) = 1 + 1i;

        elseif (real(signal_echantillonne(k)) <= 0 && imag(signal_echantillonne(k)) >= 0)
            symboles_decides(k) = -1 + 1i;

        elseif (real(signal_echantillonne(k)) >= 0 && imag(signal_echantillonne(k)) <= 0)
            symboles_decides(k) = 1 - 1i;
        end
    end
    TEB_pb= [TEB_pb length(find(symboles_decides~=Symboles))/(2*length(Symboles))];
    
   end
   figure;
    semilogy(Eb_N0_db,TEB_pb,'r-o');
    xlabel('E_b/N_0 en décibels');
    ylabel('TEB');
    title({'le TEB de la chaine passe-bas equivalente'});
 
% %5)Comparaison entre TEB simulé et TEB théorique
    
    Teb_theorique =qfunc(sqrt(4*(10.^(Eb_N0_db/10))));    
    figure;
    semilogy(Eb_N0_db,TEB_fp,'r-o');
    hold on;
    semilogy(Eb_N0_db,Teb_theorique,'b-*');
    grid
    %tracé le taux d'erreur binaire obtenu en fonction du rapport signal à bruit par bit à l'entrée du récepteur (Eb/N0) en décibels.
    legend('TEB simulé','TEB theorique');
    xlabel('Eb/N0 en décibels');
    ylabel('TEB');
    title({'Comparaison du TEB_{theorique} et TEB_{estimé}';' de la chaine passe-bas equivalente'});



% (5) - Tracer les constellations en sortie du mapping et en sortie de
% l'échantillonneur pour valeur donnée de Eb/N0.
scatterplot(Symboles);
title("Les constellations en sortie du mapping");
%Pour une valeur de Eb/N0 égale à 6dB.
scatterplot(signal_echantillonne);
title("Les constellations en sortie de l'échantillonneur");


% (6) - Comparaison TEB de la chaine passe-bas équivalente et de la chaine
% sur fréquence porteuse.
figure(13);
semilogy(Eb_N0_db,TEB_fp,'x-');
hold on;
semilogy(Eb_N0_db,TEB_pb,'v-');

title("Taux d'erreur binaire pour les deux chaines");
xlabel("Eb/N0 (en dB)");
ylabel("TEB");
legend("Chaine passe-bas équivalente","Chaine sur fréquence porteuse");
grid on;

%2)%comparaison des DSP des deux chaines
    figure;
    DSP_fp=(1/length(X))*abs(fft(X,2^nextpow2(length(X)))).^2;
    plot(linspace(-Fe / 2, Fe / 2, length(DSP_fp)), fftshift(DSP_fp),'g');
    hold on;
    DSP_pb=(1/length(Xe))*abs(fft(Xe,2^nextpow2(length(Xe)))).^2;
    plot(linspace(-Fe / 2, Fe / 2, length(DSP_pb)),fftshift(DSP_pb));
    title('DSP du signal émis sur les deux chaines');
    ylabel('DSP');
    xlabel('fréquence en Hz');
    legend( 'DSP chaine sur fequence porteuse', 'DSP chaine passe-bas equivalente')


