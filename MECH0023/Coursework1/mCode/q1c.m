clc
clear
close all

%def vars
E = 70e9;
b = 0.05;
t = 0.0019;
m = 1.2;
l = 1.1;
f = 240;
zeta = 0.003;
Y = 0.001*sqrt(2);

k = (E*b*(t^3))/(4*l^3);
wn = sqrt(k/m);
w = f*2*pi;
c = 2*m*zeta*wn;

r = w/wn;
X = Y*((1 + (2*zeta*r)^2)/(((1-(r^2))^2) + (2*zeta*r)^2))^(1/2);