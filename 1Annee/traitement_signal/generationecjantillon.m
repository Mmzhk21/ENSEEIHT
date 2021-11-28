N = 100;
f1 = 1000;
f2 = 3000;
Fe = 10000;
Te = 1/Fe ;
indice = [0:Te:(N-1)*Te];
x = cos(2*pi*f1*indice) + cos(2*pi*f1*indice);

figure
plot(indice,x)
xlabel('temps(secondes)')
ylabel('amplitude')

f = [0:Fe/N:Fe-1];
Fc =2500;
T = Fc/Fe;
F1 =-50:50;
F2 = -30:30;

h = 2*T*sinc(2*T*F1);
figure;
plot(h);
H = fft(h);
Y = fftshift(H);
figure;
plot(linspace(-Fe/2,Fe/2,length(H)),abs(Y));
F_x = filter(h,1,x);
figure;
plot(indice,F_x);


