clc
clear
close all

%% geometry of plate

theta = deg2rad(30); %angle of crack in degrees
heightCrack = 0.015; %height of crack
% gap = heightCrack*tan(theta/2);
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

C1 = [
    1;
    xi;
];

C2 = [
    1,-1;
    1,1;
    1,1;
    1,-1;
];

C3 = [
    1;
    nu;
];

C4 = [
    1,-1;
    1,-1;
    1,1;
    1,1;
];

N = (1/4).*(C2*C1.*C4*C3); % shape function matrix

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

jacobianC = zeros(2,4,4,4);

B3 = zeros(4,8,4,4);
for i = 1:4
    for j = 1:4
        jacobianC(:,:,j,i) = subs(jacobianB(:,:),[xi,nu],[xi2(j),nu2(j)]);
    end
end
BTemp2 = [1,3,5,7];
BTemp3 = [2,4,6,8];
BTemp4 = [3,4];

for k = 1:4
    for l = 1:4
        for i = 1:2
            for j = 1:4
                B3(i,BTemp2(j),l,k) = jacobianC(i,j,l,k);
                B3(BTemp4(i),BTemp3(j),l,k) = jacobianC(i,j,l,k);
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
thickness = 0.002;
E = 40e9;
D1 = [
    1,poisson,0;
    poisson,1,0;
    0,0,(1-poisson)/2;
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
    3,3;
    3,17;
    3,19;
    17,17;
    17,19;
    19,19;
];

ElementIndex(:,:,2) = [
    2,2;
    2,3;
    2,4;
    2,9;
    3,3;
    3,4;
    3,9;
    4,4;
    4,9;
    9,9;
];

ElementIndex(:,:,2) = ElementIndex(:,:,2).*2-1;

ElementIndex(:,:,3) = [
    9,9;
    4,9;
    5,9;
    6,9;
    4,4;
    4,5;
    4,6;
    5,5;
    5,6;
    6,6;
];

ElementIndex(:,:,3) = ElementIndex(:,:,3).*2-1;

ElementIndex(:,:,4) = [
    8,8;
    8,9;
    6,8;
    7,8;
    9,9;
    6,9;
    7,9;
    6,6;
    6,7;
    7,7;
];

ElementIndex(:,:,4) = ElementIndex(:,:,4).*2-1;

Indexer = [
    1,1;
    1,3;
    1,5;
    1,7;
    3,3;
    3,5;
    3,7;
    5,5;
    5,7;
    7,7;
];

test = ones(8,8);

K = zeros(20,20);

for j = 1:4
    for i = 1:numel(ElementIndex(:,1))
        K(ElementIndex(i,1,j):ElementIndex(i,1,j)+1,ElementIndex(i,2,j):ElementIndex(i,2,j)+1) = K(ElementIndex(i,1,j):ElementIndex(i,1,j)+1,ElementIndex(i,2,j):ElementIndex(i,2,j)+1) + K2(Indexer(i,1),Indexer(i,2),j);
    end
end

for i = 1:19
    K(i+1,i) = 0;
end

%% nodal forces

F1 = 200e6;
alpha = pi/2; %degrees positive y = 0, clockwise +ve
height = 0.03;
F2x = (F1*(sin(alpha))*height)/3;
F2y = (F1*(cos(alpha))*height)/3;

if F2y <= 0.001
    F2y = 0;
elseif F2x <= 0.001
    F2x = 0;
else
end

F3 =[
    0;
    0;
    0;
    0;
    0;
    0;
    0;
    0;
    F2x;
    F2y;
    F2x;
    F2y;
    F2x;
    F2y;
    0;
    0;
    0;
    0;
    0;
    0;
];

displacements = K\F3;
displacements(abs(displacements)< 1e-10) = 0;