clc
clear 
close all

alpha = pi/3;
beta = pi/6;
F = 1000;

A = [-cos(alpha) 0 cos(beta) 0 0 0;
    -sin(alpha) 0 -sin(beta) 0 0 0;
    cos(alpha) 1 0 1 0 0;
    sin(alpha) 0 0 0 1 0;
    0 -1 -cos(beta) 0 0 0;
    0 0 sin(beta) 0 0 1];
B = [0; F; 0; 0; 0; 0];

[L,U] = lu(A); %splits matrix A such that A = L*U, L is lower triangular, U is upper triangular 
y = L\B;
sol = U\y;