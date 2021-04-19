clc
clear 
close all

%mesh
m = -2:0.1:2;
[x,y] = meshgrid(m);

%function
z = (sin((pi/2).*x)).*(cos((pi/2).*y));

%gradient function
[gx,gy] = gradient(z,0.2,0.2);
contour(m,m,z)
hold on 
quiver(m,m,gx,gy)
hold off

%formatting
axis('image');
xlabel('x-axis')
ylabel('y-axis')
title('Plot of scalar function and gradient vectors')
grid on