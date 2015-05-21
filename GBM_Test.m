% test GBM
clear all
close all

alpha = 0.01;
sigma = 0.1;
p0 = 0.0969;
Lifespan=30;
t = 0: 1: Lifespan;
itr = 100;
elPrice = zeros(itr, Lifespan);

for j = 1: itr
     elPrice(j, :) = GBM(Lifespan, alpha, sigma, p0);
end
%  
elecPriceAnal = p0.*exp(alpha*t);

figure 
plot(elPrice);
hold on 
plot(elecPriceAnal, '--r');