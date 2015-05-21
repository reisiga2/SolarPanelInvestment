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
function expected_NPV = NPVcalc(EleSurplus, EleProduce,sellbackpercent,Elecprice,sizeratio)
    
   
    Lifespan = 30;
    %Elecprice2=Elecprice;
    %plot(Elecprice2)
   %first year incentive 
%    incent_y1= sum(ElePurchase+EleProduce-EleSurplus)*0.03*Elecprice;
%    incent_y= sum(ElePurchase)*0.03*Elecprice
   
    Roofarea=60;
    Maintain=0;
    PVarea=sizeratio*Roofarea;     
    BOS=400*PVarea;
    Panelcost=120*PVarea;
    Initialcost=BOS+Panelcost;
    Interestrate=0.02;
    Inflationrate=0;
    
    Discountrate=Interestrate+Inflationrate;
    Offset=EleProduce-EleSurplus;
    Offsetsum=sum(Offset);
    EleSurplussum=sum(EleSurplus);
    
    Revenue = EleSurplussum .* Elecprice.* sellbackpercent + Offsetsum * Elecprice;
    total_rev = zeros(size(Elecprice, 1),1);
    
    
   for k = 1 : Lifespan
       %y=y+(Revenue+incent_y-Maintain)*(1+Discountrate)^(-i);
       total_rev = total_rev +(Revenue(:,k)- Maintain)*(1+Discountrate)^(-k);
   end        
   NPV = total_rev - Initialcost;  
   expected_NPV = mean(NPV);
end


