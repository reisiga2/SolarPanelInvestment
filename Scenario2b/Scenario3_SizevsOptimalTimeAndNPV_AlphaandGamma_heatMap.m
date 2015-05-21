clear all
close all

roofArea = 60;
alpha = -0.002;
sigma = 0.1;
p0 = 0.0969;
lifeSpan = 30;
sellbackpercent = 0.5;
gamma  = -0.004; % rate of decline in the price of technology
% read the PV generation for the sizeRatio 0.4. This is in fact the mean
% value of the PV generation (Demand is hidden in here.)
data = xlsread('20PVsize.xlsx');
eachYearNPV = zeros(1, 30);
AlphaChanges = 25;
gammachanges = 23;
NPV_star = zeros(AlphaChanges, gammachanges ); % 4 is same as the one for k that follows
time_star = zeros(AlphaChanges, gammachanges);
t = 0: lifeSpan;
sizeratio = 0.4;


for j = 1 : gammachanges
    gamma = gamma + 0.004;
    for k = 1 : AlphaChanges % I just use 4 to have plots for 4 different values of gamma.
        alpha = alpha + 0.002;
        pricePath = p0.*exp(alpha.*t);
        for startYear = 1 : lifeSpan
            eachYearNPV(startYear) = NPVcalc_SC2(data(2, 8), data(1, 8),sellbackpercent...
                           ,pricePath, lifeSpan, startYear, sizeratio, gamma);  % 8 corresponds to the the data for size 24m^2      
        end
        [NPV_star(k, j), time_star(k, j)] = max(eachYearNPV);
        if (NPV_star <= 0)
           time_star(k, j) = lifeSpan + 1; % represent that we should never do it.
        end       
    end
end
time_star = time_star - 1;
NPVStar2 = flipRow(NPV_star);
gamma = 0: 0.004: 0.1;
alpha = 0: 0.002: 0.05;
figure
%imagesc(NPVStar2);
imagesc(alpha, gamma, NPVStar2);
colorbar;
gca()
ylabel('\alpha (growth rate of energy price)')
xlabel('\gamma (decline rate of technology cost)')
set(gca, 'YTick', 0:0.01:0.05);
set(gca, 'YTickLabel', {'0.05', '0.04', '0.03', '0.02', '0.01', '0'});

figure
timeStar2 = flipRow(time_star);
imagesc(alpha, gamma, timeStar2);
colorbar;
gca()
ylabel('\alpha (growth rate of energy price)')
xlabel('\gamma (decline rate of technology cost)')
set(gca, 'YTick', 0:0.01:0.05);
set(gca, 'YTickLabel', {'0.05', '0.04', '0.03', '0.02', '0.01', '0'});


