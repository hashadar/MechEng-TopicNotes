clc
clear
close all

%define vars
V0 = 1;
l = 8;
x = linspace(0,l,1000);

%create matrices
A = [8 -2 0 -4 0 0 0 0 0;
    -2 8 -2 0 -4 0 0 0 0;
    0 -2 8 0 0 -4 0 0 0;
    0 0 0 8 -2 0 -4 0 0;
    0 0 0 -2 8 -2 0 -4 0;
    0 0 0 0 -2 8 0 0 -4;
    0 0 0 0 0 0 8 -2 0;
    0 0 0 0 0 0 -2 8 -2;
    0 0 0 0 0 0 0 -2 8];

B = [2*V0*exp(-((pi^2)*6)/(4*l^2));
    0;
    0;
    2*V0*exp(-((pi^2)*4)/(4*l^2));
    0;
    0;
    4*V0*cos((pi*2)/(2*l)) + 2*V0*exp(-((pi^2)*2)/(4*l^2));
    4*V0*cos((pi*4)/(2*l));
    4*V0*cos((pi*6)/(2*l))];

%solve matrix
sol = A\B; %estimate solution

%exact answer check
solution = zeros(9,1); %initalise exact solution matrix 
k = 1; %initialise counter

for j = [6 4 2] %y-values
    for i = [2 4 6] %x-values
        solution(k) = V0*(cos((pi*i)/(2*l)))*exp(-((pi^2)*j)/(4*l^2)); %equation for exact solution
        k = k+1; %advance counter
    end
end

%find percentage error between estimate and exact
error = 100.*sqrt((solution - sol).^2)./solution;