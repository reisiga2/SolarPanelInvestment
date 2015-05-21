function cost = changeSizeCost(panelSize1, panelSize2, panelUnitCost)
    
    if (panelSize2 - panelSize1 >= 0)
         cost = (panelSize2 - panelSize1) * panelUnitCost;
    else
         cost = inf;
    end
    

end