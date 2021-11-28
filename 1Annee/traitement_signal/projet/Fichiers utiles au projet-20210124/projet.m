clear 
close all

% 3.1.1 Génération du signal NRZ
% 1 :length(NRZ)-1)*Te
 
    Nbit = 100;
    train = randi([0 1], 1, Nbit);
    Fe = 48000;
    Te = 1/Fe;
    Ts =1/300;
    Ns = floor(Ts/Te);
    NRZ = repelem(train , Ns);
% 2. Tracez le signal NRZ
    %figure;
    %plot(linspace(0, length(NRZ)*Ts, length(NRZ)), NRZ);
    %title("Signal NRZ");
    %xlabel("Temps en seconde");
   % ylabel("NRZ(t)");
     
% 3. tracez la densité spectrale de puissance du signal NRZ
    f =(0:(Fe-1));
    Snrz =(1/4)*Ts*((sinc(f*Ts)).^2) + (1/4)*fft(1);
   % figure; 
    %plot(f,Snrz);
   % title("DSP NRZ");
    %xlabel("Fréquence en Hz");
   % ylabel("dsp nrz(f)");
    
 % 3.1.2 Génération du signal modulé en fréquence
   % 1 : génération du signal x(t)
        F0 =6000;
        F1 = 2000;
        phi0 = rand*2*pi;
        phi1 = rand*2*pi;
        t = (0:Te:(length(NRZ)-1)*Te);
        cos0 = cos(2*pi*F0*t + phi0);
        cos1 = cos(2*pi*F1*t + phi1);
        x = (1-NRZ).*cos0 + NRZ.*cos1;
    % 2.Tracez le signal x(t)
         %figure; 
         %plot(t,x); hold on
        % plot(t,NRZ, 'r'); 
        % title("Signal modulé en fréquence");
       %  xlabel("Temps en seconde");
       %  ylabel("x(t)");
        
     %  3.Calculez la densité spectrale de puissance du signal modulé en fréquence x(t)
        X = fft(x);
        Sx = (1/length(X))*((abs(X)).^2);
        % 4 tracez la densité spectrale de puissance du signa lmodulé en fréquence,
         % figure; 
          %plot(linspace(-Fe/2,Fe/2,length(X)),Sx);
          %title("densité spectrale de puissance du signal modulé en fréquence");

         %3.1.2  Canal de transmission à bruit additif, blanc et Gaussien
        
        SNR= 50;
        Px=mean(abs(x).^2);
        Pb=Px*(10^(SNR/10));

        x_bruit = x + sqrt(Pb)*randn(1,length(x));
     %   figure; 
      %  plot(x_bruit);
       % title("signal bruité");
         
% Démodulation par filtrage

   %Synthèse du filtre passe-bas
    Fc = 3000;
    T = Fc/Fe;
    ordre = 111;
    Fb = (-(ordre-1)/2:(ordre-1)/2);
    h_filte_b = 2*T*sinc(2*T*Fb);
    
    Hb = fft(h_filte_b);
    Y = fftshift(Hb);
    
    indice = (0:Te:(length(x_bruit)-1)*Te);
    
    F_x = filter(h_filte_b,1,[x_bruit zeros(1,(ordre-1)/2 )]);
    F_x = F_x(((ordre-1)/2)+1:end);
    %figure;
    %plot(indice,F_x);
    
    % Synthèse du filtre passe-haut
    
   
    hp = -h_filte_b;
    hp((ordre+1)/2)=1-2*T;
   % figure;
  %  figure;
     % plot(hp);
      %title("reponse impulsionnelle")
      %xlabel("temps en secondes");
       %ylabel("hp(t)");
   %figure;
   % plot(linspace(-Fe/2,Fe/2,length(Hb)),abs(hp));
    %title("reponse fréquentielle du filtre pass haut");
    %xlabel("fréquence en Hz") ; 
    %ylabel("Hp(f)");
    
    F_y = filter(hp,1,[x_bruit zeros(1,(ordre-1)/2 )]);
    F_y = F_y(((ordre-1)/2)+1:end);
    figure;
    plot(indice,F_y);
    title("signal en sortie du filtre pass haut");
    
%tracés à realiser
    %1
  %     figure;
    %   plot(h_filte_b);
     %  title("reponse impulsionnelle")
      % xlabel("temps en secondes");
       %ylabel("h_filtre_b(t)");
       
      % figure; 
  
     %   plot(linspace(-Fe/2,Fe/2,length(Hb)),Hb);
      % plot(linspace(-Fe/2,Fe/2,length(Hb)),abs(Y));
       %title("réponse frequentielle");
      % xlabel("fréquence en Hz") ; 
       %ylabel("Hb(f)");
    % 2 
    %figure;
    %plot(linspace(-Fe/2,Fe/2,length(Sx)),Sx);
    %hold on;
   % plot(linspace(-Fe/2,Fe/2,length(Hb)),abs(Y));
  %  title("Densité spectrale du signal filtré");
 %   hold off;
    
    
    % 3
    G= fftshift(F_x);
    
    %figure;
   % plot(linspace(-Fe/2,Fe/2,length(G)),G);
   % title("DSP du signal en sortie du filtre pass bas");
    %figure;
    plot(F_x);
    title("signal en sortie du filre pass bas");
    
   
    
%Detection d'énergie

   % 1
   
  
   
  r=reshape(F_x,Ns,Nbit);
  s= sum(abs(r.^2));
  K= (max(s)-min(s))/2;
  
  L= s>K;
  
   % 2
         erro=0;
         trans =0;
         for i=1:Nbit
             if L(i) == train(i)
                 trans = trans +1;
             else 
                erro = erro +1;
             end
         end
        
         tr = 1-Nbit/Nbit;
          
 load('DonneesBinome4.mat');
 reconstitution_image(bits);
 which reconstitution_image;
 
 reconstitution_image(suite_binaire_reconstruite);
 which reconstitution_image;
          






