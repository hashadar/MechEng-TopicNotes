clc
clear
close all

%mesh
m = 0.5:0.1:2.5;
[x,y] = meshgrid(m);

%function
ui = log(y).*exp(-x);
uj = log(x).*exp(-y);

%divergence
d = divergence(ui,uj);
hold on 
contour(m,m,d,'showtext','on')
quiver(m,m,ui,uj)
hold off

%formatting
axis('image');
xlabel('x-axis')
ylabel('y-axis')
title('Plot of vector field and associated divergence')