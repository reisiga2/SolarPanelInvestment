%run energyplus for 20 times
clear all
close all
clc


%PVsizeratio=0.05:0.05:1;
load=0:0.5:10;

%[EleSurplus, EleProduce] = EnergyPlusRunloadvariation(load);
for i= 1:length(load)

[EleSurplus(i), EleProduce(i)] = EnergyPlusRunloadvariation(load(i));
 
end