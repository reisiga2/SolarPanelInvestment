clear all;clc;
close all

%result=[0;0;0];
PVsizeratio = 0:0.05:1; %str2double(cellsizeratio{1}{1});
maxSize = 60;
sellbackpercent=0.5;
alpha = 0.02;
sigma = 0.1;
p0 = 0.0969;
% PVsizeratio=0.5;
Lifespan=30;
%t = 0: 1: Lifespan -1;
t = 1: Lifespan;
%iteration = 2000;
%Elecprice = zeros(iteration, Lifespan);
%GENERATE electricity price paths and save them
%  for j = 1: iteration
%      Elecprice(j, :) = GBM(Lifespan, alpha, sigma, p0);
%  end
%  
 elecPriceAnal = p0.*exp(alpha*(t-1));

 A = xlsread('C:\Users\Mostaffa\Dropbox\GeorgiaTech\NSF project\Energy and Building paper\Scenario3\20PVsize.xlsx');
 %A = xlsread('C:\PV_code\Scenario3\20PVsize.xlsx');
 A=[[0;0], A];
%numerical case
for i=1:size(PVsizeratio, 2)
      EleSurplus = A(2,i);
      EleProduce = A(1,i);
    %[EleSurplus, EleProduce] = EnergyPlusRun(PVsizeratio(i));
   %y(i)=NPVcalc(EleSurplus, EleProduce,sellbackpercent,Elecprice, PVsizeratio(i));
   %use the expected value of the GBM
   y_anal(i)=NPVcalc(EleSurplus, EleProduce,sellbackpercent, elecPriceAnal, PVsizeratio(i));
end

% plot NPV versus size....
figure

%bestSize = PVsizeRatio(argmax(y)) * maxSize;
x = PVsizeratio * maxSize;
% plot(x, y,  'linewidth', 1.5);
% xlabel('Size of the solar panel (m^2)');
% ylabel('NPV ($)');


% plot NPV versus size....

%bestSize_anal = PVsizeRatio(argmax(y_anal)) * maxSize;
%x = PVsizeratio * maxSize;
plot(x, y_anal, 'linewidth', 1.5);
xlabel('Size of the solar panel (m^2)');
ylabel('E(NPV) ($)');
