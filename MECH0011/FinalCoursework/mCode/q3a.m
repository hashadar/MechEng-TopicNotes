clc
clear
close all

%import data
data = readmatrix('suppFiles.xlsx','Sheet','Boundary Layer','Range','A2:B102');

%plot data
plot(data(:,2), data(:,1))
axis image
grid on
xlim([0 1])
ylim([0 1])
xlabel('y/\delta')
ylabel('u/U')
title('Graph to show the boundary layer velocity profile')