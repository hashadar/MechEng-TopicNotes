clc
clear
close all

%define variables
k = 1;
%transfer function
sys = tf([k 8*k],[0.05 1 -4.05 -81]);
%plot root locus
figure1 = figure;
rlocus(sys)
xlim([-16 1])
ylim([-20 20])

%input zeta and wn, vectorise from minimum value to arbitrary value
zeta = linspace(0.6,0.9,4);
wd = 7;
wn = wd./sqrt(1 - zeta.^2);
sgrid(zeta,wn)