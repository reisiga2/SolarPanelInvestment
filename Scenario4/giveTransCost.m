function transCost = giveTransCost(timeHorizon, roofArea, panelUnitCost, delta, gamma,d)
      
    for t = 1 : timeHorizon
        iterator1 = 1;
        for panelSize1 = 0: delta: roofArea
            iterator2 = 1;
            for panelSize2 = 0: delta: roofArea                  
                transCost(iterator1, iterator2, t)...
                        = changeSizeCost(panelSize1, panelSize2, panelUnitCost*exp(-gamma * (t-1)))/(1+d)^(t-1);
                    iterator2 = iterator2 + 1;
            end
                iterator1 = iterator1 + 1;
        end
    end

end