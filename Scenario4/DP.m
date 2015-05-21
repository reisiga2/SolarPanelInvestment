function [bestPath, minCost] = DP(T, numberOfStates, stateCost, transCost)

    [path, value] = forwardPath(T, numberOfStates, stateCost, transCost);
    [bestPath, minCost] = backtrack(path, value);

end