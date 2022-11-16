%HD
clc
clear 

data = readmatrix('dataimport.xlsx');

VSource = cat(2,data(:,5),data(:,6));
VResistor = cat(2,data(:,7),data(:,8));
VResistor2 = cat(2,data(:,9),data(:,10));

%plot(VResistor2(:,1),VResistor2(:,2),'LineWidth',1,'color',[0.4940 0.1840 0.5560])
plot(VResistor(1:40,1),VResistor(1:40,2),VResistor2(1:40,1),VResistor2(1:40,2))
grid on
axis 'auto xy'
xlim([0,0.01])
ylim([0,150])
xlabel('Time/s')
ylabel('Voltage/V')
legend('5 {\mu}F','25 {\mu}F')

%'color',[0.4940 0.1840 0.5560]