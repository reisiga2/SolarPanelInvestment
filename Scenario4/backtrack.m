function [p, minCost] = backtrack(path, cost)
    col = size(path, 2);
    [minCost, index] = max(cost(:, col));
    p = path(index, :);

end