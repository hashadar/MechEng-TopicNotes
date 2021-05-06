clc
clear
close all

%vars
pint = 4e6;
a = 8.5e-3;
b = 10e-3;
c = 11.5e-3;
ri = 0.0085;
ro = 0.01;

%internal
sigmaRI = -pint;
sigmaThetaI = -pint.*((b^2 + a^2)/(b^2 - a^2));

%external
sigmaRO = 0;
sigmaThetaO = pint.*((c^2 + b^2)/(c^2 - b^2));

%sigmaThetaO circle
p1 = nsidedpoly(1000,'Center',[sigmaThetaO/2 0],'Radius',abs(sigmaThetaO/2));
%sigmaRO circle
p2 = nsidedpoly(1000,'Center',[sigmaRI/2 0],'Radius',abs(sigmaRI/2));
%third circle
p3 = nsidedpoly(1000,'Center',[(sigmaRI + sigmaThetaO)/2 0],'Radius',abs((sigmaThetaO - sigmaRI)/2));

plot(p1)
hold on
xline(0);
yline(0);
xlabel('\sigma')
ylabel('\tau')
title('Graph to show Mohrs circle')
grid on 
axis image
plot(p2)
plot(p3)
hold off