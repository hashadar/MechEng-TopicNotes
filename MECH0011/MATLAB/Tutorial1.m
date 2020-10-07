%Hasha Dar
clc
clear
close all

[x,y]=meshgrid(-2:0.5:2,1:0.5:4); %field

u = 0.*x; %x vector
v = (4.*log(y) -2.*y + 10); %y vector

quiver(x, y, u, v) %plots quiver with arrow base at x, y and direction u, v
axis([-2.5 2.5 0.5 5]) %formatting