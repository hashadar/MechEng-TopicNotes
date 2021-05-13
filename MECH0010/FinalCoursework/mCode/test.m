clc
clear 
close all 

sys = tf([20],[1 1 20]);

k = 0.129;
sys2 = tf([20],[1 (20*k +1) 20]);
stepinfo(sys,'RiseTimeThreshold',[0.00 1],'SettlingTimeThreshold',0.05)