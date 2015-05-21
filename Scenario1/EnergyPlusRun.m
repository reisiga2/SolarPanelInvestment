function [EleSurplus, EleProduce] = EnergyPlusRun(sizeratio)

addpath('C:\PV_code\Arizona\')
idf=fopen('ArizonaHouse2012.idf');
C = textscan(idf,'%s','delimiter','\n');
cellsizeratio= textscan(C{1}{3510},'%s','delimiter',',');
cellsizeratio{1}{1}=num2str(sizeratio);
C{1}{3510}=[cellsizeratio{1}{1},',                 ',cellsizeratio{1}{2}];
fid_out=fopen('C:\PV_code\Arizona\ArizonaHouse2012.idf','wt');
fprintf(fid_out,'%s\n',C{1}{:});
fclose(fid_out);
system(['C:\EnergyPlusV7-0-0\RunEPlusYuna ','C:\PV_code\Arizona\ArizonaHouse2012 Arizona']);
Meter=csvread('C:\PV_code\Arizona\ArizonaHouse2012Meter.csv',49,1);
EleSurplus = Meter(:,1)/3600000;
EleProduce = Meter(:,3)/3600000;

end