clear all;clc;
close all

PVsizeratio = 0.4; 
load=0:0.5:10;
A = xlsread('C:\PV_code\Scenario1\20demand.xlsx');
maxSize = 60;
sellbackpercent=0:0.05:1;
p0 = 0.0969;
Lifespan=30;
t = 0: 1: Lifespan - 1;
alpha = 0.02;
y = zeros(size(load, 2),size(sellbackpercent, 2));
%GENERATE electricity price paths and save them
for i=1:size(load, 2)
      EleSurplus = A(2,i);
      EleProduce = A(1,i);% use this if you want to run energy plus for new config   
    for n = 1 : size(sellbackpercent, 2)                   
            Elecprice = p0.* exp(alpha.*t);             
            y(i, n) = NPVcalc(EleSurplus, EleProduce, ...
                          sellbackpercent(n), Elecprice,PVsizeratio);
             %bestSize = PVsizeRatio(argmax(y)) * maxSize;                
    end  
end

% plot
y2 = flipud(y);
imagesc(sellbackpercent,load,y2)
colorbar;

set(gca, 'YTick', [0:2:10]);
set(gca, 'YTickLabel', {'10', '8', '6', '4', '2', '0'});
xlabel('Sellback ratio');
ylabel('Plug load in the house (W/m^2)');


