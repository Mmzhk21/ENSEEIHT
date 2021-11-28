% 4.1 Démodulateur FSK-Contexte de synchronisation idéale
x1 = x.*cos0;
x2 = x.*cos1;
int_x1 = zeros(1,Ns);
int_x2 = zeros(1,Ns);
for i=1:Ns 
    int_x1 = int_x1 + x1(i);
    int_x2 = int_x2 + x2(i);
end
difference =  int_x2 - int_x1;
bits_retrouve = zeros(1,Nbit); 
for i=1:Ns
    if difference(i)>0
      bits_retrouve(i) = 1;
    else 
        bits_retrouve(i) = 0;
    end
end
bits_retrouve = difference>0;
         erro1=Nbit/2;
         
         for i=1:Nbit
             if bits_retrouve(i) == train(i)
                
                erro1 = erro1 -1;
             end
         end
         tr1 = erro1/Nbit;
         
 load('DonneesBinome4.mat');
 reconstitution_image(bits);
 which reconstitution_image;
 
 reconstitution_image(suite_binaire_reconstruite);
 which reconstitution_image;
         