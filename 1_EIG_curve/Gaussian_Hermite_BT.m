function res = Gaussian_Hermite_BT(mu, sigma, n)


%% this function is used for the Active learning for calculating the EIG 
%% according to Lindley's Bayesian optimization framework and Bradley-Terry model
%% GaussHermite quadrature is used to estimation the EIG

% paper submitted to NIPS 2018.

% 
% May 17, 2018 



 
 fs1 = @(x) (1./(1+exp(-sqrt(2).*sigma.*x-mu))).*(-log(1+exp(-sqrt(2).*sigma.*x-mu)))./sqrt(pi);
 fs2 = @(x) (1-1./(1+exp(-sqrt(2).*sigma.*x-mu))).*(log(exp(-sqrt(2).*sigma.*x-mu)./(1+exp(-sqrt(2).*sigma.*x-mu))))./sqrt(pi);
 fs3 = @(x) 1./(1+exp(-sqrt(2).*sigma.*x-mu))./sqrt(pi);
 fs4 = @(x) (1-1./(1+exp(-sqrt(2).*sigma.*x-mu)))./sqrt(pi);

[x, w] = GaussHermite_2(n);
 es1 = sum(w.*fs1(x));
 
 es2 = sum(w.*fs2(x));
 
 es3 = sum(w.*fs3(x));
 es3 = es3.*log(es3);
 
 
 es4 = sum(w.*fs4(x));
 es4 = es4.*log(es4);
 
 res = es1 + es2 - es3 - es4;