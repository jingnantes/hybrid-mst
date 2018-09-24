%% test relationship between EIG, mu, sigma

% paper submitted to NIPS 2018.
% 

clear all
close all
clc

 n = 30; %% sample nodes in Gaussian-Hermite quadrature estimation
 mu_vector = [-5:0.5:5]; % mean 
 sigma_vector = [0.05:0.5:5]; % std
% 
% 
for i = 1:length(sigma_vector)
    for j = 1:length(mu_vector)
        mu = mu_vector(j);
        sigma = sigma_vector(i);
        eig(i,j) = Gaussian_Hermite_BT(mu, sigma, n);
    end
end
FontSize = 30;
figure;
set(gca,'FontSize',FontSize);
[X,Y] = meshgrid(mu_vector,sigma_vector);
surf(X,Y, eig);
xlabel('s_{ij}'),ylabel('\sigma_{ij}');
title('EIG');
%saveas(gcf, 'eig_surf.png');

figure;
set(gca,'FontSize',FontSize);
contour(X,Y,eig,'ShowText','on');
xlabel('s_{ij}'),ylabel('\sigma_{ij}');
title('EIG');
%saveas(gcf,'eig_contour.png');
 
