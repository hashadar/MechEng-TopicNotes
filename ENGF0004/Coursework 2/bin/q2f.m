clc
clear 
close all
%forces
F = [1000 3000 4500];

%lengths of members
L12 = [6 8 5];
L23 = [10 12 8];
L13 = [9 7 4];

%initalise matrix
sol = zeros(9,10);

%initalise counter
counter = 0;

%nested loops, iterates between F and then between A1, A2, A3 and stores in sol matrix
for i = 1:3
    for j = 1:3
        %calculate alpha and beta
        alpha = acos((L12(j)^2 + L23(j)^2 - L13(j)^2)/(2*L12(j)*L23(j)));
        beta = acos((L13(j)^2 + L23(j)^2 - L12(j)^2)/(2*L13(j)*L23(j)));
        
        %calculate A and B matrices
        A = [-cos(alpha) cos(beta) 0 0 0 0;
            -sin(alpha) -sin(beta) 0 0 0 0;
            cos(alpha) 0 1 1 0 0;
            sin(alpha) 0 0 0 1 0;
            0  -cos(beta) -1 0 0 0;
            0 sin(beta) 0 0 0 1];
        B = [0; F(i); 0; 0; 0; 0];
        
        %generate result
        temp = (A\B)';
        
        %increment counter
        counter = counter + 1;
        
        %store result
        sol(counter, 5:10) = temp;
    end
end

%table formatting
sol(:,1) = repelem(F',3,1);
sol(:,2) = repmat(L12',3,1);
sol(:,3) = repmat(L13',3,1);
sol(:,4) = repmat(L23',3,1);

%swap L13 and L23 columns
v = sol(:, 7);
sol(:, 7) = sol(:, 6);
sol(:, 6) = v;

%clean up values
for i=1:numel(sol)
    if sol(i) < 0.01 && sol(i) > -0.01
        sol(i) = 0;
    end
end

%table generation
T = array2table(sol);
T.Properties.VariableNames = {'Force', 'L12', 'L23', 'L13', 'N12', 'N13', 'N23', 'R2x', 'R2y', 'R3y'};
