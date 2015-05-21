clear all;clc;
close all

%global C cellsizeratio result; 
result=[0;0;0];
PVsizeratio = 0:0.5:1; %str2double(cellsizeratio{1}{1});
maxSize = 60;
sellbackpercent=0.5;

% PVsizeratio=0.5;
Lifespan=30;
iteration = 1000;
alpha = 0: 0.01: 0.02;
sigma = 0: 0.01: 0.1;
y = zeros(size(alpha, 2), size(sigma, 2), size(PVsizeratio, 2));
Elecprice = zeros(iteration, Lifespan+1);
%GENERATE electricity price paths and save them
for i=1:size(PVsizeratio, 2)
      [EleSurplus, EleProduce] = EnergyPlusRun(PVsizeratio(i));
    
    for n = 1 : size(alpha, 2)
        for m = 1: size(sigma, 2)             
            for j = 1: iteration                
                 Elecprice(j, :) = GBM(Lifespan, alpha(n), sigma(m), 0.0969);
            end
             y(n, m, i) = NPVcalc(EleSurplus, EleProduce, ...
                          sellbackpercent, Elecprice,PVsizeratio(i));
             %bestSize = PVsizeRatio(argmax(y)) * maxSize;
        end        
    end   
end

% find the best sizes

bestSize= zeros(size(alpha, 2), size(sigma, 2));
for i = 1 : size(alpha, 2)
    for j = 1: size(sigma, 2)
        myMax = y(i,j, 1);
        index = 1;
        for k=1: size(PVsizeratio, 2)
            if(y(i,j, k) > myMax)
                myMax = y(i, j, k);
                index = k;
            end
        end
        bestSize(i, j) = PVsizeratio(index)* maxSize;
    end
end

bestSize2 = flipRow(bestSize);
figure
imagesc(sigma, alpha, bestSize2);
colorbar;
gca()
ylabel('\alpha (Rate of growth)')
xlabel('\sigma (Volatility)')
%set(gca, 'YTick', 0:0.03:0.15);
%set(gca, 'YTickLabel', {'0.15', '0.12', '0.09', '0.06', '0.03', '0'});


        
        

