%HD
clc
clear

%import data
data = readmatrix('dataImport.xlsx','Sheet','q2');

%datasets 
VResistor = cat(2,data(:,5),data(:,6));
PhaseResistor = cat(2,data(:,7),data(:,8));

%VRMS
VSq1 = VResistor(:,2).^2;
VRMSResistor = sqrt(sum(VSq1)/numel(VSq1));

%PF
PFResistor = cos(PhaseResistor(:,2));

%graph plotting
plot(VResistor(:,1),VResistor(:,2))
grid on
axis 'auto xy'
xlim([0,0.1])
xlabel('Time/s')
ylabel('Voltage/kV')