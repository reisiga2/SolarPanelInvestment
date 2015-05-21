function p = bestPath(t, stateNum, numberOfStates)
        
    if t > 1
        k =  argmin(transitionCost(t, stateNum, numberOfStates));
        p = [bestPath(t - 1, k, numberOfStates), stateNum];
        
     else
        p = 1;
    end

end