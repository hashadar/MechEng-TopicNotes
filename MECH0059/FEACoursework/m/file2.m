clc
clear
close all

%% definition of elements and nodes
% 4 4-noded elements in 3D matrix

A(:,:,1) = [
    0,0;
    0,0.015;
    0.035,0.015;
    0.031,0;
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
    0.039,0;
    0.035,0.015;
    0.07,0.015;
    0.07,0;
]; %x,y clockwise (m)

%% shape functions

syms xi nu % define xi nu as symbolic variables for differentiation

%defintion of shape functions 

N = [
    (1/4)*(1-xi)*(1-nu);
    (1/4)*(1+xi)*(1-nu);
    (1/4)*(1+xi)*(1+nu);
    (1/4)*(1-xi)*(1+nu);
]; % shape function matrix

%% jacobian

% define matrix of xi and nu

D1 = [
    xi,nu;
];

% initialise matrix of differentials

jacobianB = sym(zeros(2,4));

% create matrix of differentials

for i = 1:2
    for j = 1:4
        jacobianB(i,j) = diff(N(j),D1(i));
    end
end

% initialise jacobian matrix

jacobianA = sym(zeros(2,2,4));

% create jacobian matrix

for i = 1:4
    jacobianA(:,:,i) = jacobianB*A(:,:,i);
end

xi2 = [
    -1/sqrt(3);
    -1/sqrt(3);
    1/sqrt(3);
    1/sqrt(3);
];

nu2 = [
    -1/sqrt(3);
    1/sqrt(3);
    -1/sqrt(3);
    1/sqrt(3);
];

jacobian1 = sym(zeros(2,2,4,4)); % 3rd dimension = node, 4th dimension = element

for i = 1:4
    for j = 1:4
        jacobian1(:,:,j,i) = subs(jacobianA(:,:,i),[xi,nu],[xi2(j),nu2(j)]);
    end
end

%% b matrix 

B1 = [
    1,0,0,0;
    0,0,0,1;
    0,1,1,0;
];

B2 = zeros(4,4,4,4);

for i = 1:4
    for j = 1:4
        BTemp1 = inv(jacobian1(:,:,j,i));
        B2(1:2,1:2,j,i) = BTemp1;
        B2(3:4,3:4,j,i) = BTemp1;
    end
end

B3 = zeros(4,8,4,4);
jacobianC = zeros(2,4,4,4);
for i = 1:4
    for j = 1:4
        jacobianC(:,:,j,i) = subs(jacobianB(:,:),[xi,nu],[xi2(j),nu2(j)]);
    end
end

BTemp2 = [1,3,5,7];
BTemp3 = [2,4,6,8];

for i = 1:4
    for j = 1:4
        for k = 1:4
            for l = 1:2
                B3(l,BTemp2(k),j,i) = jacobianC(l,k,j,i);
                B3(l+2,BTemp3(k),j,i) = jacobianC(l,k,j,i);
            end
        end
    end
end

B = zeros(3,8,4,4);

for i = 1:4
    for j = 1:4
        B(:,:,j,i) = B1*B2(:,:,j,i)*B3(:,:,j,i);
    end
end

%% d matrix 

poisson = 0.3;
thickness = 0.002; %(m)
E = 40e9; %(Pa)
D1 = [
    1,poisson,0;
    poisson,1,0;
    0,0,(1-poisson^2)/2;
];
D = (E/1-poisson^2)*D1;

%% stiffness matrix

K1 = zeros(8,8,4,4);

for i = 1:4
    for j = 1:4
        K1(:,:,j,i) = thickness*B(:,:,j,i)'*D*B(:,:,j,i)*det(jacobian1(:,:,j,i));
    end
end

K2 = zeros(8,8,4);

for i = 1:4
    for j = 1:4
        K2(:,:,i) = K2(:,:,i) + K1(:,:,j,i);
    end
end

% assembly of stiffness matrix

ElementIndex(:,:,1) = [
    1,1;
    1,3;
    1,17;
    1,19;
    3,1;
    3,3;
    3,17;
    3,19;
    17,1;
    17,3;
    17,17;
    17,19;
    19,1;
    19,3;
    19,17;
    19,19;
];

ElementIndex(:,:,2) = [
    3,3;
    3,5;
    3,7;
    3,17;
    5,3;
    5,5;
    5,7;
    5,17;
    7,3;
    7,5;
    7,7;
    7,17;
    17,3;
    17,5;
    17,7;
    17,17;
];

ElementIndex(:,:,3) = [
    17,17;
    17,7;
    17,9;
    17,11;
    7,17;
    7,7;
    7,9;
    7,11;
    9,17;
    9,7;
    9,9;
    9,11;
    11,7;
    11,7;
    11,9;
    11,11;
];

ElementIndex(:,:,4) = [
    15,15;
    15,17;
    15,11;
    15,13;
    17,15;
    17,17;
    17,11;
    17,13;
    11,15;
    11,17;
    11,11;
    11,13;
    13,15;
    13,17;
    13,11;
    13,13;
];

Indexer = [
    1,1;
    1,3;
    1,5;
    1,7;
    3,1;
    3,3;
    3,5;
    3,7;
    5,1;
    5,3;
    5,5;
    5,7;
    7,1;
    7,3;
    7,5;
    7,7;
];

K = zeros(20,20);

for j = 1:4
    for i = 1:numel(ElementIndex(:,1))
        K(ElementIndex(i,1,j):ElementIndex(i,1,j)+1,ElementIndex(i,2,j):ElementIndex(i,2,j)+1) = K(ElementIndex(i,1,j):ElementIndex(i,1,j)+1,ElementIndex(i,2,j):ElementIndex(i,2,j)+1) + K2(Indexer(i,1),Indexer(i,2),j);
    end
end
%{
for i = 1:19
    K(i+1,i) = 0;
end
%}
K(:,[1,2,5,6]) = [];
K([1,2,5,6],:) = [];

%K = K + triu(K,1)';
%% nodal forces

Fmag = 200e6; %(N/m^2)
alpha = pi/2; %degrees positive x = 0, clockwise +ve
weight = [
    1/6;
    2/3;
];
Fu3 = (Fmag*(sin(alpha))*weight(1));
Fv3 = (Fmag*(cos(alpha))*weight(1));
Fu5 = Fu3;
Fv5 = Fv3;
Fu4 = (Fmag*(sin(alpha))*weight(2));
Fv4 = (Fmag*(cos(alpha))*weight(2));

F = [
    0;
    0;
    0;
    0;
    Fu3;
    Fv3;
    Fu4;
    Fv4;
    Fu5;
    Fv5;
    0;
    0;
    0;
    0;
    0;
    0;
];

displacements = K\F;
displacements(abs(displacements)< 1e-10) = 0;