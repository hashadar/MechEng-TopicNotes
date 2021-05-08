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
M_A = -(2/3)*R_Ay*L; %moment at A