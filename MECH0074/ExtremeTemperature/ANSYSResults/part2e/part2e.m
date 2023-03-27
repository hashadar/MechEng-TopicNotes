%% HD

clc
clear
close all

%% import data

L50m = readmatrix('maximumStress-50m.txt');
L10m = readmatrix('maximumStress-10m.txt');
L50mBend = readmatrix('deformationL1-50m-bottom-pipe-bend');
L10mBend = readmatrix('deformationL1-10m-bottom-pipe-bend');

L50m(1,:) = [];
L10m(1,:) = [];
L50mBend(1,:) = [];
L10mBend(1,:) = [];

T = linspace(-160-22,240-22,21);

%% plots

plot(T,L50m(:,5), T,L10m(:,5), 'LineWidth',1.5)
grid on
xlabel(['Temperature T-T_0/' char(176) 'C']);
ylabel('Maximum stress \sigma /Pa');
xticks(-160-22:20:240-22)
legend('50m maximum combined stress','10m maximum combined stress')