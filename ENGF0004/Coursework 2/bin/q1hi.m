clc
clear
close all

%mesh
m = -pi/4:0.05:pi/4;
[x,y] = meshgrid(m);

%function
z = tan(x.*y);

%laplacian
L = del2(z);

%plotting
subplot(1,2,1)
surf(x,y,z)
axis('square');
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
title('Plot of function')
subplot(1,2,2)
surf(x,y,L)
axis('square');
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
title('Plot of Laplacian')