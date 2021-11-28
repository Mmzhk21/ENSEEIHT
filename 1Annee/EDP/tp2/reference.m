function uref=reference(ic,lambda,Nx,dx,kt)
% Evaluation de la solution de référence en les points du maillage.
% uref(x)=u0(x-a*t)
%
% Inputs :
% ------
%
% ic :  choix de la condition initiale: 0 -> fonction porte, sinon densité gaussienne.
%
% lambda: nombre de Courant.
%
% Nx : Nombre de pas d'espace.
%
% dx : Pas d'espace.
%
% kt : Indice du pas de temps courant. 
%
% Output :
% ------
%
% uref : solution évaluée en les noeuds du maillage.
%
%*****************************************

uref=zeros(Nx+2,1);
if(ic==0)
  % Fonction porte 
  xi=0.25;
  xj=1;
  xx=0:Nx+2;
  tmp=find((dx*xx>=xi+dx*lambda*kt)&(dx*xx<=xj+dx*lambda*kt));
  uref(tmp)=2;  
else  
  % Densité gaussienne
  gaussian=@(x,m,var)exp(-(x-m)^2/(2*var^2))/(var);  
  
  n0=1;
  var0=0.1;
  for j=2:Nx+1
    uref(j)=(1/5)*gaussian((j-lambda*kt)*dx,n0,var0);
  end    
end
  

end
