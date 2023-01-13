%% MECH0059 FEA Assignment 2022/2023
%  UCL Mechanical Engineering
%  Hasha Dar
%  week7

clc
clear
close all

%% geometry of plate

% SpppppppppppppppppppppppppppppppppF
%  p      2               3        pF
%  p              p                pF
%  p             p p               pF
%  p      1     p   p     4        pF
% S0pppppppppppp     pppppppppppppppF

% 0 = origin
% S = pinned support
% F = 200MPa tension force applied to right side of plate

% height = 0.030;% height of plate in m
% width = 0.070; %width of plate in m
theta = deg2rad(30); %angle of crack in degrees
% length2Crack = 0.035; %length to crack in m
heightCrack = 0.015; %height of crack
gap = heightCrack*tan(theta/2);

%% definition of elements and nodes
% 4 4-noded elements in 3D matrix

A(:,:,1) = [
    0,0;
    0,0.015;
    0.035,0.015;
    0.035-(gap/2),0;
]; %x,y clockwise (m)
A(:,:,2) = [
    0,0.015;
    0,0.030;
    0.035,0.030;
    0.035,0.015;
]; %x,y clockwise (m)
A(:,:,3) = [
    0.035,0.015;
    0.035,0.030;
    0.070,0.030;
    0.070,0.015;
]; %x,y clockwise (m)
A(:,:,4) = [
    0.035+(gap/2),0;
    0.035,0.015;
    0.07,0.015;
    0.07,0;
]; %x,y clockwise (m)

%% shape functions

syms xi nu

tempA = [
    1;
    xi;
];

tempB = [
    1,-1;
    1,1;
    1,1;
    1,-1;
];

tempC = [
    1;
    nu;
];

tempD = [
    1,-1;
    1,-1;
    1,1;
    1,1;
];

N = (1/4).*(tempB*tempA.*tempD*tempC); % shape function matrix

% jacobian

tempE = [
    xi,nu;
];

jacobian1 = zeros(2,4);
jacobian1 = sym(jacobian1);

for i = 1:2
    for j = 1:4
        jacobian1(i,j) = diff(N(j),tempE(i));
    end
end

