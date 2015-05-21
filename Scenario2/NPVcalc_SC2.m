% A script that parses energy plus output (meters) and calculate PV system
% Net Present Value(NPV)
% NPV=sum{(Revenue-Cost)/(1+d)^t} 
% d - discount rate,equals to the sum of interest rate and inflation rate
% Cost includes installation cost and maintenance cost
% Revenue= Surplus+Offset
% This calculates the expected NPV given a size, sell back ratio and a
% several path of energy price.

% 
%%
function NPV = NPVcalc_SC2(EleSurplus, EleProduce,sellbackpercent,Elecprice, lifeSpan, startYear, sizeratio, gamma)
    
    % Here we only calculate NPV for one single path of price. 
    
    Roofarea=60; % change it based on your problem
    Maintain=0; 
    PVarea=sizeratio*Roofarea;     
    BOS=400*PVarea; % 400 is an assumption, one can use different value
    Panelcost=120*PVarea; % 120 is just an assumption
    Initialcost=BOS+Panelcost;
    Interestrate=0.05; % this is what we assume
    Inflationrate=0;
    
    Discountrate=Interestrate + Inflationrate;
    Offset=EleProduce-EleSurplus;
    Offsetsum=sum(Offset);
    EleSurplussum=sum(EleSurplus);
    
    Revenue = EleSurplussum .* Elecprice.* sellbackpercent + Offsetsum * Elecprice;
    total_rev = zeros(size(Elecprice, 1),1);
    % this is the model we use to calculate the initial cost starting at
    % 2014
    %beta = 0.7; % see the paeper for this. We just assumed this value.
    %modeledCost = 46.25*(exp(0.17 *(startYear + 28)))^(-beta);
    % we should investigate more on this value.
    initCost = Initialcost * exp(-gamma * (startYear - 1))*(1+Discountrate)^(-startYear + 1);
    
   for k = startYear : lifeSpan
       %y=y+(Revenue+incent_y-Maintain)*(1+Discountrate)^(-i);
       total_rev = total_rev +(Revenue(:,k)- Maintain)*(1+Discountrate)^(-k + 1);       
   end        
   NPV = total_rev - initCost;  

end
