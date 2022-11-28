%HD
clc
clear

%import data
data = readmatrix('dataImport.xlsx','Sheet','table2');
data2 = readmatrix('dataImport.xlsx','Sheet','table2.2');

%datasets 
VResistor = cat(2,data(:,1),data(:,2));
PhaseResistor = cat(2,data(:,3),data(:,4));
VInductor = cat(2,data2(:,1),data2(:,2));
PhaseInductor = cat(2,data2(:,3),data2(:,4));
VCapacitor = cat(2,data2(:,5),data2(:,6));
PhaseCapacitor = cat(2,data2(:,7),data2(:,8));

%VRMS
VSq1 = VResistor(:,2).^2;
VRMSResistor = sqrt(sum(VSq1)/numel(VSq1));

VSq2 = VInductor(:,2).^2;
VRMSInductor = sqrt(sum(VSq2)/numel(VSq2));

VSq3 = VCapacitor(:,2).^2;
VRMSCapacitor = sqrt(sum(VSq3)/numel(VSq3));

%PF
averagePFResistor = cos(mean(PhaseResistor(0.8*numel(PhaseResistor(:,1)):end,2)));
PFResistor = cos(PhaseResistor(:,2));

averagePFInductor = cos(mean(PhaseInductor(0.8*numel(PhaseInductor(:,1)):end,2)));
PFInductor = cos(PhaseInductor(:,2));

averagePFCapacitor = cos(mean(PhaseCapacitor(0.8*numel(PhaseCapacitor(:,1)):end,2)));
PFCapacitor = cos(PhaseCapacitor(:,2));

%graph plotting
%{
plot(VCapacitor(:,1),VCapacitor(:,2),...
    VCapacitor(:,1),linspace(VRMSCapacitor,VRMSCapacitor,numel(VCapacitor(:,1))))
grid on
axis 'auto xy'
xlim([0,0.5])
xlabel('Time/s')
ylabel('Voltage/kV')
legend('V','V_{RMS}')
%}

plot(PhaseResistor(:,1),PFResistor,PhaseResistor(:,1),...
    linspace(averagePFResistor,averagePFResistor,numel(PhaseResistor(:,1))))
grid on
axis 'auto xy'
xlim([0,0.2])
xlabel('Time/s')
ylabel('Power factor')
legend('Power Factor','Converged value')