%% HD

clc
clear
close all

%% import data

ansys = readmatrix('avg-stress-x-direction-3D.txt');
% step | time | min Pa | max Pa | avg Pa
ansys(1,:) = [];

%% theoretical result

% constants

alpha = 1.196e-05; %ansys
E = 2.1e11; %ansys 
intTempPipe = 22; %degC
T = linspace(-160,240,21)'; %degC
stressxx = -alpha*E*(T - intTempPipe);

T2 = linspace(-160-22,240-22,21)';

%% plot

plot(T2,ansys(:,5),T2,stressxx)
grid on
xlabel(['Temperature T-T_0/' char(176) 'C']);
ylabel('Stress \sigma_m /Pa');
xlim([-185,220])
xticks(-160-22:20:240-22)
ylim([-6e8,5e8])
yticks(-6e8:1e8:5e8)
legend('ANSYS','Theoretical')

%% perc diff

percDiff = (ansys(:,5)-stressxx)./stressxx;
percDiffAvg = sum(abs(percDiff))/21;