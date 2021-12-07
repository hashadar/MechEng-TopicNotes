%HD
clc
clear
close all

%define variables
k = 1;
%transfer function
sys = tf([k],[0.05 1 -4.05 -81]);
%plot root locus
rlocus(sys)
xlim([-40 40])
ylim([-40 40])