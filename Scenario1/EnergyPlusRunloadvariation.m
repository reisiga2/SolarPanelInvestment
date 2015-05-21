function [EleSurplus, EleProduce] = EnergyPlusRunloadvariation(load)

addpath('C:\PV_code\Arizona\')
idf=fopen('ArizonaHouse2012.idf');
C = textscan(idf,'%s','delimiter','\n');
MiscElecLoad = textscan(C{1}{2729},'%s','delimiter',',');
MiscElecLoad{1}{1}=num2str(load);
C{1}{2729}=[MiscElecLoad{1}{1},',                 ',MiscElecLoad{1}{2}];
fid_out=fopen('C:\PV_code\Arizona\ArizonaHouse2012.idf','wt');
fprintf(fid_out,'%s\n',C{1}{:});
fclose(fid_out);
system(['C:\EnergyPlusV7-0-0\RunEPlusYuna ','C:\PV_code\Arizona\ArizonaHouse2012 Arizona']);
Meter=csvread('C:\PV_code\Arizona\ArizonaHouse2012Meter.csv',49,1);
EleSurplus = sum(Meter(:,1)/3600000);
EleProduce = sum(Meter(:,3)/3600000);

end