clc
clear 
close all

%define vars
P = 237.34; %value of corrective load
W = 42.67; %camera weight
R = 0.3; %radius of curvature of curved section
L = 0.35; %length of a quarter of the beam

%calc vars
R_Ay = 0.75*(P-((W*R)/L) - 2*W); %support reaction at A
R_B = W - P - R_Ay; %support reaction at B
M_A = (2/3)*R_Ay*L; %moment at A

%bending moment equation
%x = 0
M0 = -M_A;
%x = L
M1 = -M_A + R_Ay*L;
%x = 2L
M2 = -M_A + 2*R_Ay*L;
%x = 3L
M3 = -M_A + 3*R_Ay*L + R_B*L;
%x = 4L
M4 = -M_A + 4*R_Ay*L + 2*R_B*L + P*L;

%concatenate
x = [0 L 2*L 3*L 4*L];
M = [M0 M1 M2 M3 M4];

%plot
plot(x,M,'color','red')
xlim([0 4*L])
ylim([-30 45])
grid on
hline = refline(0,0);
hline.Color = 'b';
title('Graph to show bending moment of beam')
xlabel('Length along beam/m')
ylabel('Magnitude of bending moment/Nm')