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

height = 30;% height of plate in mm
width = 70; %width of plate in mm
theta = deg2rad(30); %angle of crack in degrees
length2Crack = 35; %length to crack in mm
heightCrack = 15; %height of crack
gap = heightCrack*tan(theta/2);

%% definition of elements and nodes
% 4 4-noded elements

A(:,:,1) = [
    0,0;
    0,heightCrack;
    length2Crack,heightCrack;
    length2Crack-gap,0;
    ]; %clockwise