clc
clear
close all 

%define params
syms A zeta wn t wd phi

xt = A*(exp(-zeta*wn*t))*sin(wd*t + phi);
diff(xt,t)