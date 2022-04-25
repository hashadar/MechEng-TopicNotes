%tyre model params
clc
clear
close all
%% Set parameters

%------------------------------------------------------%
%Custom numbers for example vehicle in TRD paper
m       = 200;         
lf       = 1; 
lr       = 0.5;
l       = lf+lr;
h       = 0.3;
rsd     = 0.25;
s1      = 1;
s2      = 0;
%------------------------------------------------------%

%Define steering relation: Ackermann steering:
SteeringRelation1 = @(delta) atan(l/(l/tan(delta)-s1)); %Left steer angle [rad]
SteeringRelation2 = @(delta) atan(l/(l/tan(delta)+s1)); %Right steer angle [rad]

%Enviromental parameters
g    = 9.81;   %[m/s^2] gravitational acceleration

%front tyre Magic Formula parameters
p.tyre1.R0   =       0.548;    % Free tyre radius [m]
p.tyre1.Fz0  =   50000;        % tyre nominal force [N]
p.tyre1.kz   = 1190000;        % Tyre vertical stiffness [N/m]
p.tyre1.pCx1 =       1.6;      % Shape factor Cfx for longitudinal force         
p.tyre1.pDx1 =       0.75;     % Longitudinal friction Mux at Fznom         
p.tyre1.pDx2 =      -0.05;     % Variation of friction Mux with load         
p.tyre1.pKx1 =      15;        % Longitudinal slip stiffness Kfx/Fz at Fznom 
p.tyre1.pCy1 =       1.3;      % Shape factor Cfy for lateral forces
p.tyre1.pDy1 =       0.7;      % Lateral friction coefficient at Fz0
p.tyre1.pDy2 =      -0.1;      % Lateral friction coefficient dependency on Fz
p.tyre1.pEy1 =       0.15126;  % Lateral curvature Efy at Fznom
p.tyre1.pEy2 =       0.0;      % Lateral curvature dependency on Fz
p.tyre1.pKy1 =       7.702;    % peak cornering stiffness (Cfa=pKy1*Fz0)
p.tyre1.pKy2 =       2.13;     % vertical force at which peak Cfa occurs (Fz=pKy2*Fz0)

%rear tyre Magic Formula parameters
p.tyre2.R0   =     0.548;    % Free tyre radius [m]
p.tyre2.Fz0  = 50000;        % tyre nominal force [N]
p.tyre2.kz   = 1130000;      % Tyre vertical stiffness [N/m]
p.tyre2.pCx1 =     1.6;      % Shape factor Cfx for longitudinal force         
p.tyre2.pDx1 =     0.75;     % Longitudinal friction Mux at Fznom         
p.tyre2.pDx2 =    -0.05;     % Variation of friction Mux with load         
p.tyre2.pKx1 =    15;        % Longitudinal slip stiffness Kfx/Fz at Fznom  
p.tyre2.pCy1 =     1.3;      % Shape factor Cfy for lateral forces
p.tyre2.pDy1 =     0.7;      % Lateral friction coefficient at Fz0
p.tyre2.pDy2 =    -0.1;      % Lateral friction coefficient dependency on Fz
p.tyre2.pEy1 =    -0.26327;  % Lateral curvature Efy at Fznom
p.tyre2.pEy2 =     0.0;      % Lateral curvature dependency on Fz
p.tyre2.pKy1 =     6.484;    % peak cornering stiffness (Cfa=pKy1*Fz0)
p.tyre2.pKy2 =     1.9557;   % vertical force at which peak Cfa occurs (Fz=pKy2*Fz0)
