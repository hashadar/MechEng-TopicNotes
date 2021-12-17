clc
clear
close all

%define constants
F = [760272.966085493,622528.049680715];
mdot = 216.93;
g = 9.81;

%initialise array
ISp = zeros(1,2);

%specific impulse
for i = 1:2
    ISp(i) = (F(i))/(mdot*g);
end
    