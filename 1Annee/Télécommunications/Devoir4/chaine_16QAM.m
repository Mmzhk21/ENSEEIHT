
%%
%--------------------------------------------------------------------------
% Utilisation de la chaine passe-bas équivalente pour le calcul et
% l’estimation du taux d’erreur binaire
%--------------------------------------------------------------------------

% Initialisation des paramètres
  Rb = 2000;
    Fe = 10000;
    Te = 1/Fe;
    alpha = 0.35;
    fp = 2000;
    %Temps symbole
    Ts=1/Rb;
    %Ns
    Ns=floor(Ts/Te);
    % nb_bits
    nb_bits = 100000;
    % E/N0
    Eb_N0_db = (0:8);
    span = 8;
M = 16;
Rs = Rb / (log2(M) * 8);
nb_bits = 10000;
Ns = floor(Fe / Rs);

%%
%--------------------------------------------------------------------------
% Implantation de la chaine sans bruit
%--------------------------------------------------------------------------
% Génération de l’information binaire
bits = randi([0, M - 1], 1, nb_bits);

% Mapping permettant d'obtenir dk
dk = qammod(bits, M);
ak = real(dk);
bk = imag(dk);

% Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
Suite_diracs1 = kron(ak, [1 zeros(1, Ns - 1)]);
Suite_diracs2 = kron(bk, [1 zeros(1, Ns - 1)]);

% Génération de la réponse impulsionnelle du filtre de mise en forme
h = rcosdesign(alpha, span, Ns, 'sqrt');
retard = (span * Ns) / 2;

% Filtrage de mise en forme du signal généré sur la voie I
I = filter(h, 1, [Suite_diracs1 zeros(1, retard)]);
I = I(retard + 1 : end);

% Filtrage de mise en forme du signal généré sur la voie Q
Q = filter(h, 1, [Suite_diracs2 zeros(1, retard)]);
Q = Q(retard + 1 : end);

% Le signal transmis sur fréquence porteuse
x =  I + 1i * Q;

% Les constellations en sortie du mapping et de l’échantillonneur
figure;
plot(ak, bk, 'b*');
xlim([-3.5 3.5]);
ylim([-3.5 3.5]);
title('Les constellations en sortie du mapping')
xlabel('I');
ylabel('Q');

% Affichage du signal génerée sur la voie en phase
figure ;
plot(I);
axis([0 length(I) - 1 -1 1]);
title('Signal généré sur la voie en phase I');
xlabel('Temps en secondes');
ylabel('I(t)');

% Affichage du signal généré sur la voie en quadrature
figure ;
plot(Q);
axis([0 length(Q) - 1 -1 1]);
title('Signal généré sur la voie en quadrature Q');
xlabel('Temps en secondes');
ylabel('Q(t)');

%%
% Calcul de la DSP  du signal transmis par périodogramme
DSP_x = (1 / length(x)) * abs(fft(x, 2 ^ nextpow2(length(x)))) .^ 2;

% Affichage du signal transmis par périodogramme
figure;
plot(linspace(-Fe / 2, Fe / 2, length(DSP_x)), fftshift(DSP_x));
title('DSP du signal transmis');
xlabel('Fréquences en Hz');
ylabel('S_{x_{e}}(f)');

%%
% Génération de la réponse impulsionnelle du filtre de réception
h_r = h;

% Filtrage de réception
z = filter(h_r, 1, [x zeros(1,retard)]);
z = z(retard + 1 : end);

% Affichage du signal reçu
figure ;
plot(real(z));
axis([0 nb_bits - 1 -1 1]);
title('Figure 1 : signal reçu z sans bruit');
xlabel('Temps en secondes');
ylabel('Signal reçu z');

% Le diagramme de l’oeil en sortie du filtre de réception
diagramme_oeil = reshape(real(z), Ns, length(real(z)) / Ns);
figure;
plot(diagramme_oeil);
title("Diagramme de l'oeil sans bruit du signal reçu");
xlabel('Temps en secondes');

% Echantillonnage du signal
z_echant = z(1 : Ns : end);

% Detecteur à seuil
bits_decides = qamdemod(z_echant, M);

% Calcul du TEB
TEB_QAM = length(find(bits_decides ~= bits)) / length(bits)

%%
%--------------------------------------------------------------------------
% Implantation de la chaine avec bruit
%--------------------------------------------------------------------------
%%

TES_QAM = zeros(1,9);
TEB_QAM = zeros(1,9);

for i = 0 : 8
    % L'ajout du bruit blanc gaussien
    Puiss_sign = mean(abs(x) .^ 2);
    Puiss_bruit = Puiss_sign * Ns  / (2 * log2(M) * 10 .^ (i / 10));
    Bruit_gauss = (sqrt(Puiss_bruit) * randn(1, length(x))) + 1i * (sqrt(Puiss_bruit) * randn(1, length(x)));
    y = x + Bruit_gauss;
    
    % Filtrage de réception
    z = filter(h_r, 1, [y zeros(1,retard)]);
    z = z(retard + 1 : end);
    
    % Echantillonnage du signal
    z_echant = z(1 : Ns : end);
    
    % Les constellations en sortie du mapping et de l’échantillonneur
    figure;
    plot(real(z_echant), imag(z_echant), 'r*');
    hold on;
    plot(ak, bk, 'b*');
    legend('Les constellations en sortie du mapping','Les constellations en sortie de l’échantillonneur')
    xlabel('I');
    ylabel('Q');
    
    % Detecteur à seuil
    bits_decides = qamdemod(z_echant, M);
    
    % Calcul du TEB
    TES_QAM(i + 1) = length(find(bits_decides ~= bits)) / length(bits);
    
    % Calcul du TEB
    TEB_QAM(i + 1) = TES_QAM(i + 1) / log2(M);
end

%%
% Comparaison entre le taux d’erreur binaire (TEB) obtenu en fonction Eb/N0
% et le TEB théorique
figure;
semilogy([0 : 8], TEB_QAM, 'r*');
hold on
semilogy([0 : 8], (1 - (1 / sqrt(M))) * qfunc(sqrt((4 / 5) * 10 .^ ([0 : 8] / 10))));
grid
title('Figure 8 : Comparaison entre le TEB théorique et estimé');
legend('TEB estimé','TEB théorique')
xlabel("$\frac{Eb}{N_{o}}$ (dB)", 'Interpreter', 'latex');
ylabel('TEB');