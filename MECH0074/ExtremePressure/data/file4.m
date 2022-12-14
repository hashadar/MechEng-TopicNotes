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

fn = fn';

%import data
L4 = [31.65;149.93;332.21;521.06;712.09;857.22];
L10 = [5.35;31.49;80.99;143.54;214.08;289.12];
L20 = [1.35;8.37;22.69;42.93;68.06;97.07];

ANSYSFreqs = cat(1,L4',L10',L20')';

percDiff = zeros(numel(ANSYSFreqs(:,1)),numel(ANSYSFreqs(1,:)));

%percentage differences
for i = 1:numel(ANSYSFreqs)
    percDiff(i) = 100*(fn(i) - ANSYSFreqs(i))/ANSYSFreqs(i);
end