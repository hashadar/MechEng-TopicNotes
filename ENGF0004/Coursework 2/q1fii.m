clc
clear 
close all

syms x y
z = x*y*exp(-sqrt(x^2 + y^2));
f = (sin((pi/2)*x))*(cos((pi/2)*y));
g = gradient(f,[x,y]);

[X, Y] = meshgrid(-2:0.1:2,-2:0.1:2);
G1 = subs(g(1),[x y],{X,Y});
G2 = subs(g(2),[x y],{X,Y});
quiver(X,Y,G1,G2)