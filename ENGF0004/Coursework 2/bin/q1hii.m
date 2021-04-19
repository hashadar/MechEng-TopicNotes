clc
clear
close all

%mesh
m = -3:0.1:3;
[x,y] = meshgrid(m);

%function
z = x.*y.*exp(-sqrt(x.^2 + y.^2));

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