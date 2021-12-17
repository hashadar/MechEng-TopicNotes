clc
clear
close all

%define constants
gamma = 1.218;
d = [3.31 0.92]; %vacuum and sea level exit nozzle diameters
At = ((0.226/2)^2)*pi; %throat diameter
R = 8173/21.7;
Tc = 3570;


%initialise arrays and variables
eqn = zeros(1,2);
MachE = zeros(1,2);
ue = zeros(1,2);
syms Me

%solve for exit Mach number
for i = 1:2
    Ae = ((d(i)/2)^2)*pi;
    eqn = (1/Me)*((1 + 0.5*(gamma -1)*(Me^2))/(0.5*(gamma + 1)))^((gamma +1)/(2*(gamma - 1))) == Ae/At;
    MachE(i) = vpasolve(eqn, Me);
end

%solve for exit velocity
ue = MachE.*sqrt(gamma*R*Tc*(1 + 0.5*(gamma -1).*(MachE.^2)).^(-1));