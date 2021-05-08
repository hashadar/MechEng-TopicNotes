%Hasha Dar

clc
clear
close all

heatLoss = [547.603, 520.454, 518.159];
pressureRatio = [2.11, 2.13, 2.17];
plot(pressureRatio, heatLoss, '-o')
grid on 
xlim([2.1, 2.2])
ylim([510, 550])
xlabel('Pressure Ratio')
ylabel('Heat loss in apparatus/W')