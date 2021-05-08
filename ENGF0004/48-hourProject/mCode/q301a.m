clc
clear
close all

%import data
data = readmatrix('Section3_data.txt');

%plot data
plot(data(:,1), data(:,2))
title('Graph to show variation in signal over a period of 100 seconds')
xlim([0 100])
ylim([-5 5])
xlabel('Time/s')
ylabel('Pulse oximeter signal/arbitrary units')
grid on