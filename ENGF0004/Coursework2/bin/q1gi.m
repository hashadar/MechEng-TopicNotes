clc
clear
close all

%mesh
m = -1:0.1:1;
[x,y] = meshgrid(m);

%function
ui = 2.*cos(pi.*x);
uj = (sin(pi.*y)).^2;

%divergence
d = divergence(ui,uj);
contour(m,m,d,'showtext','on')
hold on 
quiver(m,m,ui,uj)
hold off

%formatting
axis('image');
xlabel('x-axis')
ylabel('y-axis')
title('Plot of vector field and associated divergence')