% transCost is a three dimentional matrix. for each time t it gives matrix
% whose colomn represent the cost of transitioning to the state with that
% colomn number. For example column 2 constains transition values to the state 2. 

% stateCost is matrix of the costs. the ij element is the cost of the state
% i at time j.


function [path, value] = forwardPath(T, numberOfStates, stateValue, transCost)
    % need to define transitino cost
    % need to define stateCost
    value = zeros(numberOfStates, T); 
    path = zeros(numberOfStates, T);
    value(:, 1) = stateValue(:, 1)-transCost(1,:,1)'; % we need to subtract the installation cost
    for t = 2 : T
        for i = 1: numberOfStates
            value(i, t) = stateValue(i, t) + max(-transCost(:, i, t) + value(:, t - 1)); 
            [A,path(i, t)] = max(-transCost(:, i, t) + value(:, t - 1));
        end
    end
end