clc
clear
close all 

%sun orbital characteristics 2022
%peri = 147105052000;
%aphe = 152098455000;

%a = (peri + aphe)/2;
%c = (aphe - peri)/2;
%b = sqrt(a^2 - c^2);

%orbital equation
%x = linspace(-peri,aphe,10000);
%y1 = sqrt(b^2 - ((b^2).*((x-c).^2))./(a^2));
%y2 = -sqrt(b^2 - ((b^2).*((x-c).^2))./(a^2));
%plot(x,y1,x,y2)
%grid on

thetaD = -12*(pi/180);
theta = 38.5*(pi/180);
phi = 75*(pi/180);

cosPsi = (cos(thetaD))*(sin(theta))*(sin(phi))+(sin(thetaD))*(cos(theta));
psi = acos(cosPsi);
M = sec(psi);