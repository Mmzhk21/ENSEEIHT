function Beta_chapeau = MCO(x, y)
n=length(x);
B= [zeros(n,1);1];
A = [x.^2 x.*y y.^2 x y ones(n,1)];
Ac = [A;[1 0 1 0 0 0]];
Beta_chapeau = pinv(Ac)*B;
