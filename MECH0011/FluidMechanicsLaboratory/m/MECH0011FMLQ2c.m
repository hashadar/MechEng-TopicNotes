clc
clear
close all

hold on 
a = ezplot('0.1 = y-y/(x^2+y^2)', [-3,3]');
b = ezplot('-0.1 = y-y/(x^2+y^2)', [-3,3]);
c = ezplot('1 = x^2 + y^2', [-3,3]);
title('Plot of the streamline around a cylinder in the (x, y) plane')
legend('0.1 = y-y/(x^2+y^2)','-0.1 = y-y/(x^2+y^2)','1 = x^2 + y^2')
set(a, 'color', 'red')
set(b, 'color', 'green')
set(c, 'color', 'blue')
grid on 
hold off