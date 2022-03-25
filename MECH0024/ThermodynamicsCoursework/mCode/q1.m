clc
clear
close all 

%at measurement time
thetaD = -12*(pi/180);
lati = 51.5;
theta = (90-lati)*(pi/180);
timeOfDay = 11;
phi = ((timeOfDay*360)/24 - 90)*(pi/180);

cosPsi = (cos(thetaD))*(sin(theta))*(sin(phi))+(sin(thetaD))*(cos(theta));
psi = acos(cosPsi);
M = sec(psi);
E = 1353*(0.027+0.81*exp(-0.76*M));

%angles where collector is orientated normal
thetaDNorm = (-5)*(pi/180);
latiNorm = 51.5;
thetaNorm = (90 - latiNorm)*(pi/180);
timeOfDayNorm = 12;
phiNorm = ((timeOfDayNorm*360)/24 - 90)*(pi/180);
alpha = phiNorm - thetaDNorm - thetaNorm;

EAlpha = E*(cos(thetaD)*sin(theta+alpha)*sin(phi) + sin(thetaD)*cos(theta + alpha));
Area = 920;
IncEnergy = EAlpha*Area;

%losses
absorp = 0.97;
epsi = 0.0941;
sigma = 5.67e-11;
TA = 8+273.15;
TS = 45+273.15;
h = 0.00256;

%energy bal
thetaSolar = IncEnergy*absorp;
thetaConv = Area*h*(TS - TA);
thetaRad = Area*epsi*sigma*(TS^4);
powerAvail = thetaSolar - thetaConv - thetaRad; 