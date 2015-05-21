clear all
close all

iteration = 10000; % make sure we write that in the paper. we should stick 
alpha = 0.02;
sigma = 0.1;
p0 = 0.0969;
lifeSpan = 30;
sellbackpercent = 0.5;
sizeratio = 0.4;
gamma  = 0.06; % rate of decline in the price of technology
% read the PV generation for the sizeRatio 0.4. This is in fact the mean
% value of the PV generation (Demand is hidden in here.)
%Meter=csvread('C:\PV_code\Scenario2\ArizonaHouse2012Metersizeratio0.4.csv',49,1);
Meter=xlsread('C:\PV_code\results\scenario1_sizeratio0.4normal.xlsx');
EleSurplusAll = Meter(2,:);
EleProduceAll = Meter(1,:);

eachYearNPV = zeros(1, 30);
NPV_star = zeros(1, iteration);
time_star = zeros(1, iteration);
for i = 1: iteration
   tic
   pricePath = GBM(lifeSpan, alpha, sigma, p0); 
   rand = randi([1 size(Meter, 2)]);
   EleSurplus = EleSurplusAll(rand);
   EleProduce = EleProduceAll(rand);
   for startYear = 1 : lifeSpan
        eachYearNPV(startYear) = NPVcalc_SC2(EleSurplus, EleProduce,sellbackpercent...
                   ,pricePath', lifeSpan, startYear, sizeratio, gamma);        
   end
   [NPV_star(i), time_star(i)] = max(eachYearNPV);
   if (NPV_star(i) <= 0)
       time_star(i) = lifeSpan + 1; % represent that we should never do it.
       NPV_star(i)= 0; % since you never do it, its value is zero.
   end
   toc 
end

[f,x]= hist(NPV_star, 50);
bar(x,f/sum(f));
xlabel('Maximum NPV ($)');
ylabel('Frequency');

figure
[f,x] = hist(time_star - 1, 50);
bar(x,f/sum(f));
set(gca, 'XTickLabel', {'0', '5', '10', '15', '20', '25', 'Never'});
xlabel('Optimal time of investment (year)');
ylabel('Frequency');

