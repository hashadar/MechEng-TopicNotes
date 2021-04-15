clc
clear
close all
alpha = 0.927295;
beta = 0.643501;

ATable = ["-cos(alpha)" "0" "cos(beta)" "0" "0" "0";
                "-sin(alpha)" "0" "-sin(beta)" "0" "0" "0";
                "cos(alpha)" "1" "0" "1" "0" "0";
                "sin(alpha)" "0" "0" "0" "1" "0";
                "0" "-1" "-cos(beta)" "0" "0" "0";
                "0" "0" "sin(beta)" "0" "0" "1"];
            
c = size(ATable);
c = c(1)*c(2);
for i = 1:c
    ATable(i) = eval(ATable(i));
end
A = str2double(ATable);
B = [0; 1000; 0; 0; 0; 0];

sol = A\B;