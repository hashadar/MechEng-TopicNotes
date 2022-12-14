%HD

clc
clear
close all 

alpha = [1.875;4.694;7.855;10.996;14.137;17.279]; %modal bending coeffs 
E = 200e9; %Youngs modulus GPa 
L = [4;10;20]; %length of beams 
de = 0.813; %external diameter m
di = 0.79394; %internal diameter m
rhoS = 7850; %density steel
rhoLNG = 455; %density gas
rhoEff = rhoS + rhoLNG*((di^2)/(de^2-di^2)); %density effective
A = (pi*(de/2)^2) - (pi*(di/2)^2); %cross-sectional area m^2
I = (A/16)*(de^2 + di^2); %second moment of inertia m^4

fn = zeros(3,6);
for i = 1:3
    for j= 1:6
        fn(i,j) = ((alpha(j)^2)/(2*pi))*((E*I)/(rhoEff*A*((L(i))^4)))^(0.5);
    end
end