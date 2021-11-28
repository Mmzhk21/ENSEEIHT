
% les Teb des quatres chaines:
TEB_4ASK_Theorique = (3 / 4) * qfunc(sqrt((4 / 5) * 10 .^ ([0 : 8] / 10)));
TEB_8PSK_Theorique = (2 / log2(M)) * qfunc(sqrt(2 * log2(M) * 10 .^ ([0 : 8] / 10)) * sin(pi / M))
TEB_QPSK_Theorique = (4 * (1 - (1 / sqrt(4))) * qfunc(sqrt(3 * log2(4)* 10 .^ ([0 : 8] / 10) / (3)))) / log2(4)
TEB_16QAM_Theorique = (1 - (1 / sqrt(M))) * qfunc(sqrt((4 / 5) * 10 .^ ([0 : 8] / 10)));

Eb_N0_dB = [0:8];
figure();
semilogy(Eb_N0_dB,TEB_4ASK_Theorique,'*-');
hold on;
semilogy(Eb_N0_dB,TEB_QPSK_Theorique,'o-');
semilogy(Eb_N0_dB,TEB_8PSK_Theorique,'v-');
semilogy(Eb_N0_dB,TEB_16QAM_Theorique,'x-');
legend("TEB théorique 4-ASK","TEB théorique QPSK","TEB théorique 8-PSK","TEB théorique 16-QAM");
title("Comparaison des TEB théoriques pour les modulations ASK, PSK et QAM");
grid on;
xlabel("Eb/N0 (en dB)");
ylabel("TEB");