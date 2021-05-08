%Hasha Dar
clc
clear
close all

isentropic = [0.05, 0.073, 0.117];
volumetric = [1.056, 1.064, 1.093];
total = [0.026, 0.035, 0.046];
pressureRatio = [2.11, 2.13, 2.17];
plot(pressureRatio, isentropic, '-o', pressureRatio, volumetric, '-o', pressureRatio, total, '-o')
xlim([2.1, 2.2])
ylim([0, 1.2])
xlabel('Pressure Ratio')
ylabel('Efficiency')
legend('Isentropic efficiency', 'Volumetric efficiency', 'Total efficiency')
grid on 