%Hasha Dar
clc
clear 
close all
f = 2;
k = 2;
m = 0.5;
t = linspace(-10, 10, 100);
y = (2*sin((t.*(- f^2 + 4*k*m)^(1/2))/(2*m)).*exp(-(f.*t)/(2*m)))/(4*k*m - f^2)^(1/2);
