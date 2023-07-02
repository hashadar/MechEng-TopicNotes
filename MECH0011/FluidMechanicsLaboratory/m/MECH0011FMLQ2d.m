clc
clear
close all

z = linspace(0,2*pi,90);
j = sqrt(-1);
xc = 0.094;
x = cos(z) -xc+(((1-abs(xc))^2)*(cos(z)-xc))./(1-2.*xc*cos(z)+xc.^2);
y = (sin(z) +(((1-abs(xc))^2).*(-sin(z)))./(1-2.*xc.*cos(z)+xc.^2));
plot(x, y);
grid on
axis equal
legend('x_c = 0.094')
title('Joukowsky Transformed streamlines around the aerofoil (\xi, \zeta) plane')
ylim([-0.5,0.5]);
xlim([-2,2]);