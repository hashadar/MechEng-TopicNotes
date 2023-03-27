%% HD

clc
clear
close all

%% import data

ansys = readmatrix('avg-stress-x-direction-1d-split.txt');
ansys3d = readmatrix('avg-stress-x-direction-3D-sameMaterial');
% step | time | min Pa | max Pa | avg Pa
ansys(1,:) = [];
ansys3d(1,:) = [];

%% theoretical result

% constants

alpha = 1.2e-05	; %ansys
E = 2e11; %ansys 
intTempPipe = 22; %degC
T = linspace(-160,240,21)'; %degC
stressxx = -alpha*E*(T - intTempPipe);

T2 = linspace(-160-22,240-22,21)';

%% plot

plot(T2,ansys(:,4),T2,stressxx)
grid on
xlabel(['Temperature/' char(176) 'C']);
ylabel('Stress \sigma_m /Pa');
xlim([-185,220])
xticks(-160-22:20:240-22)
ylim([-6e8,5e8])
yticks(-6e8:1e8:5e8)
legend('ANSYS','Theoretical')

%% perc diff

percDiff = (ansys(:,4)-stressxx)./stressxx;
percDiffAvg = sum(abs(percDiff))/21;