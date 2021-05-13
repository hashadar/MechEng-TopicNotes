clc
clear
close all

t = linspace(0,4*pi,1000);
k = 10;
m = 1;

R1 = 1000;
R2 = 1000;
R3 = 1000;
RP = 1000-1000.*sin(1000.*t);
VIn = 5;

VOut = VIn.*((R3)./(R3+RP) - (R1)/(R1+R2));
plot(VOut)
grid on