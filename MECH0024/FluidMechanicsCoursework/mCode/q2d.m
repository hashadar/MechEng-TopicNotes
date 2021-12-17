clc
clear
close all

%define constants
gamma = 1.218;
d = [3.31 0.92]; %vacuum and sea level exit nozzle diameters
At = ((0.226/2)^2)*pi; %throat diameter
pc = 9.7e6;


%initialise arrays and variables
eqn = zeros(1,2);
MachE = zeros(1,2);
pe = zeros(1,2);
syms Me

%solve for exit Mach number
for i = 1:2
    Ae = ((d(i)/2)^2)*pi;
    eqn = (1/Me)*((1 + 0.5*(gamma -1)*(Me^2))/(0.5*(gamma + 1)))^((gamma +1)/(2*(gamma - 1))) == Ae/At;
    MachE(i) = vpasolve(eqn, Me);
end

%solve for exit pressure
pe = pc.*(1 + 0.5*(gamma - 1).*MachE.^2).^(-((gamma)/(gamma - 1)));