clc
clear
close all

%def vars
E = 70e9;
b = 0.05;
t = 0.0019;
m = 1.2;
l = 1.1;
f = 240;
zeta = 0.003;
Y = 0.001*sqrt(2);

k = (E*b*(t^3))/(4*l^3);
wn = sqrt(k/m);
wd = wn*sqrt(1-zeta^2);
w = f*2*pi;
c = 2*m*zeta*wn;
r = w/wn;
F = 16;

FT = F*((1 + (2*zeta*r)^2)/((1-r^2)^2 + (2*zeta*r)^2))^(1/2);

syms t tau

eqn = exp(-zeta*wn*(t-tau))*sin(wd*(t-tau));

int1 = FT/(wd*m)*int(tau*eqn, tau, 0, t);
int2 = FT/(wd*m)*int(tau*eqn, tau, 0, t) + FT/(wd*m)*int(eqn, tau, 1, t);
int3 = FT/(wd*m)*int(tau*eqn, tau, 0, t) + FT/(wd*m)*int(eqn, tau, 1, 3) + FT/(wd*m)*int(0*eqn, tau, 3, t);

hold on
fplot(int1, [0,1])
fplot(int2, [1,3])
fplot(int3, [3,15])
grid on
xlabel('Time/s')
ylabel('Displacement/m')