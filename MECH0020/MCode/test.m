clc
clear
close all

m       = 200;   
V = 100;
rho = 50;
s1 = 0.5;
s2      = 0;
lf       = 1; 
lr       = 0.5;
l       = lf+lr;
h       = 0.3;
rsd     = 0.25;
beta = 0.16;
delta = 0.1;
delta1 = atan(l/(l/tan(delta)-s1));

p.tyre1.R0   =       0.5;    % Free tyre radius [m]
p.tyre1.Fz0  =   4000;        % tyre nominal force [N]
p.tyre1.kz   = 109000;        % Tyre vertical stiffness [N/m]
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
