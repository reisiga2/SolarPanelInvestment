% this function calculates the best path
% should still write the transitionCost function.

function [statePath, cost] = pathCost(t, stateNum, numberOfStates)
%     time = t;
%     currentState = stateNum;
    if t > 1
%         statePath(time, currentState) = argmin(transitionCost(t - 1, stateNum, numberOfStates));
%         time = t - 1; 
%         currentState = argmin(transitionCost(time - 1, currentState, numberOfStates));
        
        cost = min(transitionCost(t, stateNum, numberOfStates))...
                            + pathCost(t - 1 ...
                            , argmin(transitionCost(t - 1, stateNum, numberOfStates))...
                            , numberOfStates);
        
        
    else
        cost = 0;
    end
 end