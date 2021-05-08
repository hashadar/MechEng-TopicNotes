%Hasha Dar
clc
clear 
close all
f = 1;
k = 2.5;
m = 1;
t = [0,0.01,10];
y = (2*sin((t.*(- f^2 + 4*k*m)^(1/2))/(2*m)).*exp(-(f.*t)/(2*m)))/(4*k*m - f^2)^(1/2);
