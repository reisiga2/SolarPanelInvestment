%run energyplus for 20 times
clear all
close all
clc


%PVsizeratio=0.05:0.05:1;
PVsizeratio=0.05:0.05:1;


for i= 1:length(PVsizeratio)

[EleSurplus(i), EleProduce(i)] = EnergyPlusRunfordiffsize(PVsizeratio(i));
 
end