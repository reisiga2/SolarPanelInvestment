clear all
close all

roofArea = 60;
alpha = 0.02;
sigma = 0.1;
p0 = 0.0969;
lifeSpan = 30;
sellbackpercent = 0.5;
gamma  = 0; % rate of decline in the price of technology
% read the PV generation for the sizeRatio 0.4. This is in fact the mean
% value of the PV generation (Demand is hidden in here.)
data = xlsread('C:\PV_code\Scenario5\Input.xlsx');
%data = xlsread('C:\PV_code\Scenario3\20PVsize.xlsx');
%change it for different climate

eachYearNPV = zeros(1, 30);
NPV_star = zeros(4, size(data, 2) ); % 4 is same as the one for k that follows
time_star = zeros(4, size(data, 2));
t = 0: lifeSpan;
%sizeratio = 0.05:0.05:1;
sizeratio = 0.4;
pricePath = p0.*exp(alpha.*t);
for k = 1 : 4 % I just use 4 to have plots for 4 different values of gamma.
    gamma = gamma + 0.02;
    for i = 1: size(data, 2)
        for startYear = 1 : lifeSpan
%             eachYearNPV(startYear) = NPVcalc_SC2(data(2, i), data(1, i),sellbackpercent...
%                        ,pricePath, lifeSpan, startYear, sizeratio(i), gamma);  
            eachYearNPV(startYear) = NPVcalc_SC2(data(2, i), data(1, i),sellbackpercent...
                       ,pricePath, lifeSpan, startYear, sizeratio, gamma);
        end
        [NPV_star(k, i), time_star(k, i)] = max(eachYearNPV);
        if (NPV_star <= 0)
           time_star(k, i) = lifeSpan + 1; % represent that we should never do it.
        end
    end
end
time_star = time_star - 1;
% size = roofArea * sizeratio;
% stairs(size, time_star(1,:), 'r', 'linewidth' , 1.5);
% hold on
% stairs(size, time_star(2,:), '--b', 'linewidth' , 1.5);
% stairs(size, time_star(3,:), '-.g', 'linewidth' , 1.5);
% stairs(size, time_star(4,:), ':k', 'linewidth' , 1.5);
% legend('\gamma = 0.02', '\gamma = 0.04', '\gamma = 0.06', '\gamma = 0.08');
% ylabel('Expected optimal time of investment (year)');
% xlabel('Solar panel size (m^2)');
% hold off
% 
% figure
% plot(size, NPV_star(1,:), 'r', 'linewidth' , 1.5);
% hold on
% plot(size, NPV_star(2,:), '--b', 'linewidth' , 1.5);
% plot(size, NPV_star(3,:), '-.g', 'linewidth' , 1.5);
% plot(size, NPV_star(4,:), ':k', 'linewidth' , 1.5);
% legend('\gamma = 0.02', '\gamma = 0.04', '\gamma = 0.06', '\gamma = 0.08');
% ylabel('Expected optimal NPV ($)');
% xlabel('Solar panel size (m^2)');