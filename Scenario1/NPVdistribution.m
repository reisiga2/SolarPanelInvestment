clear all
close all

%PVProduction = xlsread('C:\PV_code\results\Scenario1_hugeplug.xlsx');
PVProduction = xlsread('C:\PV_code\results\scenario1_sizeratio0.4normal.xlsx');
A = PVProduction;
iteration = 10000;
sellbackpercent = 0.5;
Lifespan = 30; % make sure you put this value in the paper.
sizeratio = 0.4; % the optimal ratio obtained from the previous experiment. for the following alpha and sigma
sigma = 0.1;
alpha = 0.02;
NPV = zeros(size(A,2), 1);
p0=0.0969;
t=0:Lifespan;

%for j = 1: iteration
%    Elecprice(j, :) = GBM(Lifespan, alpha, sigma, 0.0969);
%end

Elecprice = p0.*exp(alpha*t);
for i = 1: size(A, 2)
    NPV(i) = NPVcalc(A(2, i), A(1, i),sellbackpercent,Elecprice,sizeratio);
end

[f, x] = hist(NPV, 20);
bar(x,f/sum(f));
xlabel('NPV ($)');
ylabel('Frequency')