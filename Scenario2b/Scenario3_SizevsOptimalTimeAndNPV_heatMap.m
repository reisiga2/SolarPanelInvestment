clear all
close all

roofArea = 60;
alpha = 0.02;
sigma = 0.1;
p0 = 0.0969;
lifeSpan = 30;
sellbackpercent = 0.5;
gamma  = -0.004; % rate of decline in the price of technology
% read the PV generation for the sizeRatio 0.4. This is in fact the mean
% value of the PV generation (Demand is hidden in here.)
data = xlsread('20PVsize.xlsx');
eachYearNPV = zeros(1, 30);
gammaChanges = 23;
NPV_star = zeros(gammaChanges, size(data, 2) ); % 4 is same as the one for k that follows
time_star = zeros(gammaChanges, size(data, 2));
t = 0: lifeSpan;
sizeratio = 0.05:0.05:1;
pricePath = p0.*exp(alpha.*t);

for k = 1 : gammaChanges % I just use 4 to have plots for 4 different values of gamma.
    gamma = gamma + 0.004;
    for i = 1: size(data, 2)
        for startYear = 1 : lifeSpan
            eachYearNPV(startYear) = NPVcalc_SC2(data(2, i), data(1, i),sellbackpercent...
                       ,pricePath, lifeSpan, startYear, sizeratio(i), gamma);        
        end
        [NPV_star(k, i), time_star(k, i)] = max(eachYearNPV);
        if (NPV_star <= 0)
           time_star(k, i) = lifeSpan + 1; % represent that we should never do it.
        end
    end
end
time_star = time_star - 1;
size = roofArea * sizeratio;
NPVStar2 = flipRow(NPV_star);
gamma = 0: 0.004: 0.1;
figure
%imagesc(NPVStar2);
imagesc(size,gamma, NPVStar2);
colorbar;
gca()
ylabel('\gamma (Rate of change in technology price)')
xlabel('size (m^2)')
set(gca, 'YTick', 0:0.02:0.1);
set(gca, 'YTickLabel', {'0.1', '0.08', '0.06', '0.04', '0.02', '0'});

figure
timeStar2 = flipRow(time_star);
imagesc(size,gamma, timeStar2);
colorbar;
gca()
ylabel('\gamma (Rate of change in technology price)')
xlabel('size (m^2)')
set(gca, 'YTick', 0:0.02:0.1);
set(gca, 'YTickLabel', {'0.1', '0.08', '0.06', '0.04', '0.02', '0'});




