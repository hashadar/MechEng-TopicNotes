%HD

clc
clear
close all

%def variables
m = 1.2;
E = 70e9;
l = 1.1;
wb = 0.05;
zeta = 0.003;
z0 = 0;
zdot0 = 0.04;
t = 900;

%symbolise thickness var
syms tb

%define eqn
eqn = ((zdot0)/((((E*wb*(tb^3))/(4*(l^3)*m))^(1/2))*((1 - (zeta^2))^(1/2))))*(exp(-zeta*(((E*wb*(tb^3))/(4*(l^3)*m))^(1/2))*900)) == 0.0001;

%graph eqns
eqnLeft = ((zdot0)/((((E*wb*(tb^3))/(4*(l^3)*m))^(1/2))*((1 - (zeta^2))^(1/2))))*(exp(-zeta*(((E*wb*(tb^3))/(4*(l^3)*m))^(1/2))*900));
eqnRight =0.0001;
fplot([eqnLeft eqnRight])
xlim([-0.005 0.005])%limits refined through visual inspection of plots
ylim([5e-5 15e-5])

%test eqn
%eqn2 = ((0.04)/((sqrt(((70*10^9)*0.05*(tb^3))/(4*(1.1^3)*1.2)))*(sqrt(1 - (0.003^2)))))*(exp(-0.003*(sqrt(((70*10^9)*0.05*(tb^3))/(4*(1.1^3)*1.2)))*900)) == 0.0001;

%numerically solve with given starting value obtained from graphical
%inspection
v = vpasolve(eqn,tb,0.001);