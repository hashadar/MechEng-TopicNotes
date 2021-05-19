clc
clear
close all

%define vars
i = ["EPPLER 818 Hydrofoil", "NACA 63-412 Aifoil", "RG 8 Airfoil", "YS 930 Hydrofoil"]; %index hydrofoil names from sheets for ease
Vw = 11; %39.6km/h
VwLower = 6; %21.6km/h

%pull angle of attack, cl and cd from data
%rg
rgData = readmatrix('suppFiles.xlsx','Sheet',i(3),'Range','D2:F101');

%chord length equation
RGChord = ((20000)./(1036.*(Vw^2).*(rgData(rgData(:,1) == 0,2)))) + 0.077;%finds CL at alpha = 0 and inputs into equation and solves
L = 0.5.*1036.*(Vw^2).*(rgData(rgData(:,1) == 0,2)).*((2.*RGChord)-0.154); %check
LLower = 0.5.*1036.*(VwLower^2).*(rgData(rgData(:,1) == 11,2)).*((2.*RGChord)-0.154);%alpha = 11 degrees