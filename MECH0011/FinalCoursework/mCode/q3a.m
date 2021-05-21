clc
clear
close all

%import data
data = readmatrix('suppFiles.xlsx','Sheet','Boundary Layer','Range','A2:B102');

%plot data
plot(data(:,1), data(:,2))
axis image
grid on
xlim([0 1])
ylim([0 1])
ylabel('y/\delta')
xlabel('u/U')
title('Graph to show the boundary layer velocity profile')