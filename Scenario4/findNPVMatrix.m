function NPVMatrix = findNPVMatrix(file, price, sellBackRatio, discount)
    data = xlsread(file);
    %data = data(:, 20); % this is for a test we do:))
    lifespan = size(price, 2);
    numStates = size(data, 2);
    
    produce = data(1, :);
    surplus = data(2,:);
    offset = produce - surplus;
    NPVMatrix = offset' * price + surplus' * price * sellBackRatio;
    t = 1: lifespan;
    D = (1 + discount).^(t - 1);
    D = repmat(D,numStates,1);
    NPVMatrix = NPVMatrix ./ D;
    NPVMatrix = [zeros(1, 30); NPVMatrix];
end