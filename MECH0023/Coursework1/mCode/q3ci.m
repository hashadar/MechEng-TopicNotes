clc
clear
close all

%define variables
k = 1;
%transfer function
sys = tf([k 8*k],[0.05 1 -4.05 -81]);
%plot root locus
rlocus(sys)
xlim([-25 15])
ylim([-30 30])