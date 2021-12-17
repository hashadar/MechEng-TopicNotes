clc
clear
close all

%define constants
gamma = 1.218;
d = [3.31 0.92]; %vacuum and sea level exit nozzle diameters
At = ((0.226/2)^2)*pi; %throat diameter
pc = 9.7e6;
R = 8173/21.7;
Tc = 3570;
mdot = 216.93;

%initialise arrays and variables
eqn = zeros(1,2);
MachE = zeros(1,2);
pe = zeros(1,2);
pb = [0 101325];
F = zeros(1,2);
syms Me

%solve for exit Mach number
for i = 1:2
    Ae = ((d(i)/2)^2)*pi;
    eqn = (1/Me)*((1 + 0.5*(gamma -1)*(Me^2))/(0.5*(gamma + 1)))^((gamma +1)/(2*(gamma - 1))) == Ae/At;
    MachE(i) = vpasolve(eqn, Me);
end

%solve for exit pressure
pe = pc.*(1 + 0.5*(gamma - 1).*MachE.^2).^(-((gamma)/(gamma - 1)));

%solve for exit velocity
ue = MachE.*sqrt(gamma*R*Tc*(1 + 0.5*(gamma -1).*(MachE.^2)).^(-1));

%initialise array
Ae = zeros(1,2);
%thrust
for i = 1:2
    Ae(i) = ((d(i)/2)^2)*pi;
    F(i) = mdot*ue(i) + (Ae(i))*(pe(i)-pb(i));
end
