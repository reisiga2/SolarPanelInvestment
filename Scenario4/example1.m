clear all
close all

discount = 0.05;
roofArea = 60;
delta = 3; 
panelUnitCost = 520; 
numberOfStates = (roofArea / delta) + 1;
sellBackRatio = 0.5;
p0 = 0.0969;
lifespan = 30; 
t = 0: lifespan - 1;
alpha = 0.02;
price = p0 * exp(alpha.*t);
file = '20PVsize.xlsx';
gamma = 0;
for i = 1: 4
    gamma = gamma + 0.02;
    NPVMatrix = findNPVMatrix(file, price, sellBackRatio, discount);
    transCost = giveTransCost(lifespan, roofArea, panelUnitCost, delta, gamma, discount);
    [path, value] = forwardPath(lifespan, numberOfStates, NPVMatrix, transCost);
    [bestPath, maxValue] = DP(lifespan, numberOfStates, NPVMatrix, transCost);
    myPath(i,:) = bestPath;
    myMaxVal(i) = maxValue;
end
mySizes = (myPath-1)*3;
mySizes(:,1) = 0;
size = 0:3:60; 
stairs(mySizes(1,:),'r' ,'linewidth', 1.5);
hold on
stairs(mySizes(2,:),'--b' ,'linewidth', 1.5);
stairs(mySizes(3,:),'-.g', 'linewidth', 1.5);
stairs(mySizes(4,:), ':k','linewidth', 1.5);
xlabel('Time (year)');
ylabel('Panel size (m^2)');
legend(strcat('\gamma = 0.02, NPV = $ ', num2str(round(myMaxVal(1)))),...
    strcat('\gamma = 0.04, NPV = $ ', num2str(round(myMaxVal(2)))),...
    strcat('\gamma = 0.06, NPV = $ ',num2str(round(myMaxVal(3)))) ,...
    strcat('\gamma = 0.08, NPV = $ ',num2str(round(myMaxVal(4)))));
% set(gca, 'YTick', 0:3:60);
% set(gca, 'YTickLabel', {'0', '6', '12', '18', '24', '30', '36', '42', '48', '54', '60'});

