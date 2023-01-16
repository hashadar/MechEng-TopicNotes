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
gap = 0.04; %redefined for accuracy within `double' calcs

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

syms xi nu % define xi nu as symbolic variables for differentiation

%defintion of shape functions 

B1 = [
    1;
    xi;
];

B2 = [
    1,-1;
    1,1;
    1,1;
    1,-1;
];

B3 = [
    1;
    nu;
];

B4 = [
    1,-1;
    1,-1;
    1,1;
    1,1;
];

N = (1/4).*(B2*B1.*B4*B3); % shape function matrix

%% jacobian

% define matrix of xi and nu

C1 = [
    xi,nu;
];

% initialise matrix of differentials

jacobianB = sym(zeros(2,4));

% create matrix of differentials

for i = 1:2
    for j = 1:4
        jacobianB(i,j) = diff(N(j),C1(i));
    end
end

% initalise jacobian matrix

jacobianA = sym(zeros(2,2,4));

% create jacobian matrix

for i = 1:4
    jacobianA(:,:,i) = jacobianB*A(:,:,i);
end

xi2 = [
    -1/sqrt(3);
    1/sqrt(3);
    -1/sqrt(3);
    1/sqrt(3);
];

nu2 = [
    -1/sqrt(3);
    -1/sqrt(3);
    1/sqrt(3);
    1/sqrt(3);
];

jacobian1 = sym(zeros(2,2,4,4)); % 3rd dimension = node, 4th dimension = element

for i = 1:4
    for j = 1:4
        jacobian1(:,:,j,i) = subs(jacobianA(:,:,i),[xi,nu],[xi2(j),nu2(j)]);
    end
end