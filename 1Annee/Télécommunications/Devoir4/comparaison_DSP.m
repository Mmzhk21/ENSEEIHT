    Rs = 1000;
    Fe = 10000;
    Te = 1/Fe;
    alpha = 0.35;
    fp = 2000;
    %Temps symbole
    Ts=1/Rs;
    %Ns
    Ns=floor(Ts/Te);
    % nb_bits
    nb_bits = 10000;
    % E/N0
    Eb_N0_db = (0:8);
      %span
      span=8;
      %retard
      retard=span*Ns/2;
      %nombre d'intervalle
      Nb=50;
      %l'intervalle 
      I= -Nb : Nb ;

%--------------------------------------------------------------------------
% Q1: MOdulation 4ASK
%--------------------------------------------------------------------------
    
    % Génération de l’information binaire
    bits = randi([0, 1], 1, nb_bits);

    % Mapping de Gray
    Symboles = (2 * bi2de(reshape(bits, 2, length(bits)/2).') - 3).';

    % Génération de la suite de Diracs pondérés par les symbols
    Suite_diracs = kron(Symboles, [1 zeros(1, Ns - 1)]);
    h = rcosdesign(alpha, span, Ns);
    hr = fliplr(h);     %filtre de réception
    %  signal génére a la sortie de filtre mise en forme
    x = filter(h, 1, [Suite_diracs zeros(1, retard)]);
    %suppression du retard
    x = x(retard + 1 : end);
   
%--------------------------------------------------------------------------
% Calcul de DSP et l'afficher
%-----------------------------------------------------------------------

        DSP_ASK=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
    
%--------------------------------------------------------------------------
% Modulation QPSK
%-------------------------------------------------------------------------
    %Rythm symbole
     Rs = 3000;
     %Temps symbole
      Ts=1/Rs;
     %nm_bits
      nb_bits=10000;
     %Ns
      Ns=floor(Ts/Te);
       %span
      span=8;
      %retard
      retard=span*Ns/2;
    
    % Génération de l’information binaire
    bits = randi([0, 1], 1, nb_bits);

    %Symboles de I et Q
    SymbolesI=2*randi([0, 1], 1, nb_bits)-1;
    SymbolesQ= 2*randi([0, 1], 1, nb_bits)-1 ;
    
    %symbole de signal emis
    Symboles = SymbolesI+ 1i*SymbolesQ;
    
    %Générationde la suite de Diracspondéréspar les symbols 
    %(suréchantillonnage) de I et Q
    Suite_diracsI=kron(SymbolesI, [1 zeros(1,Ns-1)]);
    Suite_diracsQ=kron(SymbolesQ, [1 zeros(1,Ns-1)]);
    h = rcosdesign(alpha/2,span,Ns);
    hr = fliplr(h);
    I = filter(h,1,[Suite_diracsI zeros(1,retard)]);
    Q = filter(h,1,[Suite_diracsQ zeros(1,retard)]);
    
    %supprimer le retard ajouté avant le filtrage
    I=I(retard+1:end);
    Q=Q(retard+1:end);
    %l'intervalle du temps
    T = 0:Te:(length(I)-1)*Te;
    x = I+ 1i*Q; 
 
%--------------------------------------------------------------------------
DSP_QPSK=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;

        
%--------------------------------------------------------------------------
%  MOdulation 8-PSK
%--------------------------------------------------------------------------
 %Rythm symbole
       Rs = 2000;
      %Temps symbole
      Ts=1/Rs;
      %nm_bits
      nb_bits=10000;
      %frequence de coupure
      Fc=1500;
      %Ns
      Ns=floor(Ts/Te);
      %span
      span=8;
      %retard
      retard=span*Ns/2;
      M = 8;

    % Génération de l’information binaire 
    bits = randi([0, M- 1], 1, nb_bits);

    % Utilisation de la fonction pskmod
    d_k = pskmod(bits, M, pi / M);
    a_k = real(d_k);
    b_k = imag(d_k);

   %Symboles de I et Q
    Suite_diracsI = kron(a_k, [1 zeros(1, Ns - 1)]);
    Suite_diracsQ = kron(b_k, [1 zeros(1, Ns - 1)]);

    % Génération de la réponse impulsionnelle du filtre de mise en forme
    h = rcosdesign(alpha, span, Ns);

    % I et Q après le filtre de mise en forme
    I = filter(h, 1, [Suite_diracsI zeros(1, retard)]);
    Q = filter(h, 1, [Suite_diracsQ zeros(1, retard)]); 
    
    %Suppression de retard
    I = I(retard + 1 : end);
    Q = Q(retard + 1 : end);

    %Signal transmis
    x =  I + 1i * Q;

%--------------------------------------------------------------------------
%  la DSP du signal émis:
%--------------------------------------------------------------------------
    
    
    DSP_8PSK=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;

        
%--------------------------------------------------------------------------
% MOdulation 16-QAM
%--------------------------------------------------------------------------
 %Rythm symbole
       Rs = 2000;
      %Temps symbole
      Ts=1/Rs;
      %nm_bits
      nb_bits=10000;
      %frequence de coupure
      Fc=1500;
      %Ns
      Ns=floor(Ts/Te);
      %span
      span=8;
      %retard
      retard=span*Ns/2;
      M = 16;

    % Génération de l’information binaire 
    bits = randi([0, M- 1], 1, nb_bits);

    % Utilisation de la fonction pskmod
    d_k = pskmod(bits, M, pi / M);
    a_k = real(d_k);
    b_k = imag(d_k);

   %Symboles de I et Q
    Suite_diracsI = kron(a_k, [1 zeros(1, Ns - 1)]);
    Suite_diracsQ = kron(b_k, [1 zeros(1, Ns - 1)]);

    % Génération de la réponse impulsionnelle du filtre de mise en forme
    h = rcosdesign(alpha, span, Ns);

    % I et Q après le filtre de mise en forme
    I = filter(h, 1, [Suite_diracsI zeros(1, retard)]);
    Q = filter(h, 1, [Suite_diracsQ zeros(1, retard)]); 
    
    %Suppression de retard
    I = I(retard + 1 : end);
    Q = Q(retard + 1 : end);

    %Signal transmis
    x =  I + 1i * Q;
    

%--------------------------------------------------------------------------
% Affichage de la DSP du signal émis: 16QAM
%--------------------------------------------------------------------------
    

    DSP_16QAM=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
    

    figure;
    plot(linspace(0,100,length(DSP_ASK)),fftshift(DSP_ASK),'g');
    hold on;
    plot(linspace(0,100,length(DSP_QPSK)),fftshift(DSP_QPSK));
    hold on 
    plot(linspace(0,100,length(DSP_8PSK)),fftshift(DSP_8PSK));
    hold on
    plot(linspace(0,100,length(DSP_16QAM)),fftshift(DSP_16QAM));
    title('DSP du signal émis');
    ylabel('DSP');
    xlabel('fréquence en Hz');
    legend('TEB 4-ASK','TEB QPSK','TEB 8PSK','TEB 16QAM');
