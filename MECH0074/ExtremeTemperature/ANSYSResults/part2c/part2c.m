%% HD

clc
clear
close all

%% import data

topStress = readmatrix('max-principal-stress-top.txt');
topShear = readmatrix('max-principal-shear-stress-top.txt');
botStress = readmatrix('max-principal-stress-bot.txt');
botShear = readmatrix('max-principal-shear-stress-bot.txt');
% step | time | min Pa | max Pa | avg Pa

topStress(1,:) = [];
topShear(1,:) = [];
botStress(1,:) = [];
botShear(1,:) = [];

T = linspace(-160-22,240-22,21);

%% plots

plot(T,topStress(:,4), T,botStress(:,4), T,topShear(:,4), T,botShear(:,4),'LineWidth',1.5)
grid on
xlabel(['Temperature T-T_0/' char(176) 'C']);
ylabel('Maximum stress \sigma /Pa');
xticks(-160-22:20:240-22)
legend('Top bend principal','Bottom bend principal','Top bend shear','Bottom bend shear')