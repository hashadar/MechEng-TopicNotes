clc
clear
close all

%define vars
i = ["EPPLER 818 Hydrofoil", "NACA 63-412 Aifoil", "RG 8 Airfoil", "YS 930 Hydrofoil"]; %index hydrofoil names from sheets for ease

%pull cl and cd from data
%eppler
epplerCL = readmatrix('suppFiles.xlsx','Sheet',i(1),'Range','E2:E79');
epplerCD = readmatrix('suppFiles.xlsx','Sheet',i(1),'Range','F2:F79');

%naca
nacaCL = readmatrix('suppFiles.xlsx','Sheet',i(2),'Range','E2:E107');
nacaCD = readmatrix('suppFiles.xlsx','Sheet',i(2),'Range','F2:F107');

%rg
rgCL = readmatrix('suppFiles.xlsx','Sheet',i(3),'Range','E2:E101');
rgCD = readmatrix('suppFiles.xlsx','Sheet',i(3),'Range','F2:F101');

%ys
ysCL = readmatrix('suppFiles.xlsx','Sheet',i(4),'Range','E2:E78');
ysCD = readmatrix('suppFiles.xlsx','Sheet',i(4),'Range','F2:F78');

%plot data
plot(epplerCL, epplerCD,'r',nacaCL,nacaCD,'g',rgCL,rgCD,'b',ysCL,ysCD,'magenta')
legend(i(1), i(2), i(3), i(4))
axis square
grid on
xlabel('C_L')
ylabel('C_D')
title('Plot of lift-to-drag ratio for ' + i(4))