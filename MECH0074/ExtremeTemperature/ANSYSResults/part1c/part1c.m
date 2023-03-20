%% HD

clc
clear
close all

%% import data

ansys = readmatrix('avg-stress-x-direction-int-temp-22-v3.txt');
% step | time | min Pa | max Pa | avg Pa
ansys(1,:) = [];

%% theoretical result

% constants

alpha = 1.196e-05; %ansys
E = 2.1e11; %ansys 
intTempPipe = 22; %degC
T = linspace(-160,240,21)'; %degC
stressxx = -alpha*E*(T - intTempPipe);

%% plot

plot(T,ansys(:,5),T,stressxx)
grid on
xlabel(['Temperature/' char(176) 'C']);
ylabel('Stress \sigma_m /Pa');
xlim([-165,245])
xticks(-160:20:240)
ylim([-6e8,5e8])
yticks(-6e8:1e8:5e8)
legend('ANSYS','Theoretical')

%% perc diff

percDiff = (ansys(:,5)-stressxx)./stressxx;
percDiffAvg = sum(abs(percDiff))/21;