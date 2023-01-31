close all
%% definition of elements and nodes
% 4 4-noded elements implemented into 3D matrix
% 3rd dimension represents element no.
% numbered clockwise from bottom left, SI units (m)
A(:,:,1) = [0,0;0,0.015;0.035,0.015;0.031,0;];
A(:,:,2) = [0,0.015;0,0.030;0.035,0.030;0.035,0.015;];
A(:,:,3) = [0.035,0.015;0.035,0.030;0.070,0.030;0.070,0.015;]; 
A(:,:,4) = [0.039,0;0.035,0.015;0.07,0.015;0.07,0;];
%% shape function + jacobian
% define matrix of xi and nu
syms xi eta
D1 = [xi,eta;];
N = [(1/4)*(1-xi)*(1-eta);(1/4)*(1-xi)*(1+eta);
    (1/4)*(1+xi)*(1+eta);(1/4)*(1+xi)*(1-eta);]; % shape function matrix
jacobianB = sym(zeros(2,4)); % initialise
for i = 1:2 %row
    for j = 1:4 % column
        jacobianB(i,j) = diff(N(j),D1(i)); 
        % shape function derivative matrix
    end
end
jacobianA = sym(zeros(2,2,4)); %initialise
for i = 1:4 % element
    jacobianA(:,:,i) = jacobianB*A(:,:,i); 
    % create jacobian matrix, 3rd dimension represents element
end
% define xi and nu values per node
% bottom left--, top left-+, top right++, bottom right+-
xi2 = [-1/sqrt(3);-1/sqrt(3);1/sqrt(3);1/sqrt(3);];
nu2 = [-1/sqrt(3);1/sqrt(3);1/sqrt(3);-1/sqrt(3);];
jacobian1 = sym(zeros(2,2,4,4)); % initialise
for i = 1:4 % element
    for j = 1:4 % node
        jacobian1(:,:,j,i) = subs(jacobianA(:,:,i),[xi,eta],[xi2(j),nu2(j)]); 
        % jacobian with values of xi and nu inputted. 
        % 3rd dimension: node, 4th dimension: element
    end
end
%% B matrix 
B1 = [1,0,0,0;0,0,0,1;0,1,1,0;];
B2 = zeros(4,4,4,4); %initialise
for i = 1:4
    for j = 1:4
        BTemp1 = inv(jacobian1(:,:,j,i));
        B2(1:2,1:2,j,i) = BTemp1;
        B2(3:4,3:4,j,i) = BTemp1;
    end
end
B3 = zeros(4,8,4,4); %initialise
jacobianC = zeros(2,4,4,4); %initialise
for i = 1:4 % element
    for j = 1:4 % node
        jacobianC(:,:,j,i) = subs(jacobianB(:,:),[xi,eta],[xi2(j),nu2(j)]); 
        % matrix of shape function derviatives with values of xi and nu inputted
    end
end
% index values for placement into matrix:
BTemp2 = [1,3,5,7];
BTemp3 = [2,4,6,8];
for i = 1:4 % element
    for j = 1:4 % node
        for k = 1:4 % column
            for l = 1:2 % row
                B3(l,BTemp2(k),j,i) = jacobianC(l,k,j,i);
                B3(l+2,BTemp3(k),j,i) = jacobianC(l,k,j,i);
            end
        end
    end
end
B = zeros(3,8,4,4); % initialise
for i = 1:4 % element
    for j = 1:4 % node
        B(:,:,j,i) = B1*B2(:,:,j,i)*B3(:,:,j,i);
        % multiplication to form B matrix per node per element
    end
end
B3 = zeros(3,8,4); % initialise
for i = 1:4 % element
    for j = 1:4 % node
        B3(:,:,i) = B3(:,:,i) + B(:,:,j,i); 
    end
end
%% D matrix 
poisson = 0.3; % poisson ratio
thickness = 0.002; % thickness of plate (m)
E = 40e9; % Young's Modulus (Pa)
D1 = [1,poisson,0;poisson,1,0;0,0,(1-poisson)/2;];
D = (E/1-poisson^2).*D1; % D matrix
%% stiffness matrix
K1 = zeros(8,8,4,4); % initialise
for i = 1:4 % element
    for j = 1:4 % node
        K1(:,:,j,i) = (transpose(B(:,:,j,i)))*D*(B(:,:,j,i))*thickness*det(jacobian1(:,:,j,i));
        % stiffness matrix at integration point
        % B^T * D * B * thickness * det(J)
    end
end
K2 = zeros(8,8,4); % initialise
for i = 1:4 % element
    for j = 1:4 % node
        K2(:,:,i) = K2(:,:,i) + K1(:,:,j,i);
        % element stiffness matrix
    end
end
% assembly of stiffness matrix using global index values
ElementIndex(:,:,1) = [1,1;1,3;1,17;1,19;3,1;3,3;3,17;3,19;17,1;17,3;17,17;17,19;
19,1;19,3;19,17;19,19;];
ElementIndex(:,:,2) = [3,3;3,5;3,7;3,17;5,3;5,5;5,7;5,17;7,3;7,5;7,7;7,17;17,3;17,5;17,7;17,17;];
ElementIndex(:,:,3) = [17,17;17,7;17,9;17,11;7,17;7,7;7,9;7,11;9,17;9,7;9,9;9,11;11,7;11,7;11,9;11,11;];
ElementIndex(:,:,4) = [15,15;15,17;15,11;15,13;17,15;17,17;17,11;17,13;11,15;11,17;11,11;11,13;
13,15;13,17;13,11;13,13;];
% local index values
Indexer = [1,1;1,3;1,5;1,7;3,1;3,3;3,5;3,7;5,1;5,3;5,5;5,7;7,1;7,3;7,5;7,7;];
K = zeros(20,20); % initialise
for j = 1:4
    for i = 1:numel(ElementIndex(:,1))
        ii = ElementIndex(i,1,j);
        jj = ElementIndex(i,2,j);
        kk = Indexer(i,1);
        ll = Indexer(i,2);
        K(ii:ii+1,jj:jj+1) = K2(kk:kk+1,ll:ll+1,j);
        % global stiffness matrix
    end
end
K(:,[1,2,5,6]) = []; % remove fixed displacements
K([1,2,5,6],:) = [];
%% nodal forces
force1 = 3000; % (N)
force2 = 6000; % (N)
alpha = pi/2; % (rad)
Fu3 = force1*sin(alpha); % (N)
Fv3 = force1*cos(alpha); % (N)
Fu5 = Fu3;
Fv5 = Fv3;
Fu4 = force2*sin(alpha); % (N)
Fv4 = force2*cos(alpha); % (N)
F = [zeros(4,1);Fu3;Fv3;Fu4;Fv4;Fu5;Fv5;zeros(6,1)];
displacements = K\F; % find nodal displacements
displacements = [0;0;displacements(1:2);0;0;displacements(3:end)];
D2 = [0,0;
    0+displacements(3),0.015+displacements(4);
    0,0.030;
    0.035+displacements(7),0.030+displacements(8);
    0.070+displacements(9),0.030+displacements(10);
    0.070+displacements(11),0.015+displacements(12);
    0.070+displacements(13),0+displacements(14);
    0.039+displacements(15),0+displacements(16);
    0.035+displacements(17),0.015+displacements(18);
    0.031+displacements(19),0+displacements(20);]; % global coordinate system with displacement
D3(:,:,1) = [D2(1),D2(2),D2(3),D2(4),D2(17),D2(18),D2(19),D2(20)]'; % displacement vectors
D3(:,:,2) = [D2(3),D2(4),D2(5),D2(6),D2(7),D2(8),D2(17),D2(18)]';
D3(:,:,3) = [D2(17),D2(18),D2(7),D2(8),D2(9),D2(10),D2(11),D2(12)]';
D3(:,:,4) = [D2(15),D2(16),D2(17),D2(18),D2(11),D2(12),D2(13),D2(14)]';
S4 = zeros(3,4); % initialise
for i = 1:4
    S4(:,i) = B3(:,:,i)*D3(:,:,i);
    % strain
end
displacements(abs(displacements)< 1e-10) = 0; % cleaning
disp4(:,1) = displacements(1:2:end);
disp4(:,2) = displacements(2:2:end);