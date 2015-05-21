clear all;clc;
close all

%global C cellsizeratio result; 
result=[0;0;0];
PVsizeratio = 0.05:0.05:1; %str2double(cellsizeratio{1}{1});
A = xlsread('C:\PV_code\Scenario3\20PVsize.xlsx');
maxSize = 60;
sellbackpercent=0.5;
p0 = 0.0969;
% PVsizeratio=0.5;
Lifespan=30;
t = 0: 1: Lifespan - 1;
alpha = 0: 0.005: 0.05;
y = zeros(size(alpha, 2),size(PVsizeratio, 2));
%GENERATE electricity price paths and save them
for i=1:size(PVsizeratio, 2)
      %[EleSurplus, EleProduce] = EnergyPlusRun(PVsizeratio(i));
      EleSurplus = A(2,i);
      EleProduce = A(1,i);% use this if you want to run energy plus for new config   
    for n = 1 : size(alpha, 2)                    
            Elecprice = p0.* exp(alpha(n).*t);             
            y(n, i) = NPVcalc(EleSurplus, EleProduce, ...
                          sellbackpercent, Elecprice,PVsizeratio(i));
             %bestSize = PVsizeRatio(argmax(y)) * maxSize;                
    end  
end

% plot
y2 = flipRow(y);
size = PVsizeratio * maxSize;
imagesc(size, alpha,y2)
colorbar;
set(gca, 'YTick', 0: 0.01: 0.05);
set(gca, 'YTickLabel', {'0.05', '0.04', '0.03', '0.02', '0.01', '0'});
xlabel('Solar panel size (m^2)');
ylabel('\alpha');


