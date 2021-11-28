function [mu_pensees, Sigma_pensees] = estimation_mu_Sigma(X_pensees)
n = size(X_pensees,1);
       mu_pensees = mean(X_pensees');
       Xc = X_pensees' - mu_pensees;
       Sigma_pensees = (1/n)*transpose(Xc)*Xc;
end