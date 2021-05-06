clc
clear
close all

%vars
pint = 4e6;
a = 8.5e-3;
b = 10e-3;
c = 11.5e-3;
ri = linspace(8.5e-3,10e-3,1000);
ro = linspace(10e-3,11.5e-3,1000);

%internal
sigmaRI = -pint.*((b^2)/((b^2)-(a^2))).*(1-((a^2)./(ri.^2)));
sigmaThetaI = -pint.*((b^2)/((b^2)-(a^2))).*(1+((a^2)./(ri.^2)));

%external
sigmaRO = -pint.*((b^2)/((c^2)-(b^2))).*(1-((c^2)./(ro.^2)));
sigmaThetaO = -pint.*((b^2)/((c^2)-(b^2))).*(1+((c^2)./(ro.^2)));

%total
r = [ri ro];
sigmaR = [sigmaRI -sigmaRO];
sigmaTheta = [sigmaThetaI -sigmaThetaO];

plot(r, sigmaTheta)