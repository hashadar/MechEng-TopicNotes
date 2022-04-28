clc
clear
close all

%pull racing line data
raceTrackXY = readmatrix('brandsHatchRaceLineXYData.csv');
%plot(raceTrackXY(:,1), raceTrackXY(:,2))

%calculate turning angle
%initialise arrays
u = zeros(numel(raceTrackXY(:,1))-1,numel(raceTrackXY(1,:)));
v = u;
a = zeros(numel(raceTrackXY(:,1))-1,1);
%generate vectors between 2 adjacent track points
for i = 1:(numel(raceTrackXY(:,1))-1)
    u(i,:) = [(raceTrackXY(i+1,1) - raceTrackXY(i,1)), (raceTrackXY(i+1,2)-raceTrackXY(i,2))];
end

%z-coordinate test values
%{
temp1 = linspace(0,10,500)';
temp2 = linspace(10,0,777-500)';
temp = [temp1;temp2];
raceTrackXY = cat(2,raceTrackXY,temp);
%}

%track curvature
CR = zeros(numel(raceTrackXY(:,1)) - 2,1);
for i = 1:numel(raceTrackXY(:,1)) -2
    a = sqrt((raceTrackXY(i+1,1) - raceTrackXY(i,1))^2 + (raceTrackXY(i+1,2) - raceTrackXY(i,2))^2);
    b = sqrt((raceTrackXY(i+2,1) - raceTrackXY(i+1,1))^2 + (raceTrackXY(i+2,2) - raceTrackXY(i+1,2))^2);
    c = sqrt((raceTrackXY(i+2,1) - raceTrackXY(i,1))^2 + (raceTrackXY(i+2,2) - raceTrackXY(i,2))^2);
    q = (a^2 + b^2 - c^2)/(2*a*b);
    CR(i,1) = c/(2*sqrt(1-q^2));
end

%track length
%initialise vars
trackLength = zeros(numel(raceTrackXY(:,1))-1,1);
for i = 1:(numel(raceTrackXY(:,1)) -1)
    L = sqrt((raceTrackXY(i+1,1) - raceTrackXY(i,1))^2 + (raceTrackXY(i+1,2) - raceTrackXY(i,2))^2);
    trackLength(i+1) = trackLength(i)+ L;
end

%fix array irregularities
trackLengthTemp = trackLength;
trackLengthTemp(end,:) = [];

%concat arrays for indexing
CR = cat(1,CR(1,1),CR(:,1));
CR = cat(1,CR(:,1),CR(end,1));
CR = cat(2,CR(:,1),trackLength);

%check for z-coordinate in data and generate slope array
road.slope = zeros(numel(raceTrackXY(:,2))-1,1);
if size(raceTrackXY,2) == 3
    for i = 1:numel(raceTrackXY(:,3)) - 1
        c = sqrt((raceTrackXY(i+1,1) - raceTrackXY(i,1))^2 + (raceTrackXY(i+1,2) - raceTrackXY(i,2))^2);
        z = raceTrackXY(i+1,3) - raceTrackXY(i,3);
        road.slope(i) = atan(z/c);
    end
else
    road.slope(:,1) = 0;
end

%fix array irregularity
road.slope = [0;road.slope];

%concat with track length
road.slope = cat(2,road.slope(:,1),trackLength);

%transmission
gearbox.i0 = 5; %final drive ratio at the differential
gearbox.effic = 0.9; %drivetrain efficiency

%index initial position of vehicle
initialPosVector = [raceTrackXY(2,1) - raceTrackXY(1,1); raceTrackXY(2,2) - raceTrackXY(1,2)];
normInitialPosVector = initialPosVector/norm(initialPosVector);
normInitialPosVector = cat(1,normInitialPosVector,0);

%vehicle
veh.curbMass =  100; %curb mass (kg)
veh.driverMass = 60; %driver mass (kg)
veh.massFactor =  1.05; %mass factor
veh.g =   9.81; %grav constant (m/s^2)
veh.cd =  0.1; %drag coefficient
veh.fa =  0.85; %frontal area (m^2)
veh.rho = 1.225; %air density (kg/m^3)
road.cr = 0.001; %road load coefficient
veh.mass = veh.curbMass*veh.massFactor + veh.driverMass;

m = veh.mass;
s1 =  0.3;
s2 =  0;
lf =  1; 
lr =  1;
l  = lf+lr;
h  =  0.3;
rsd = 0.25;

p.tyre1.R0   =       0.5;      % Free tyre radius [m]
p.tyre1.Fz0  =    4000;        % tyre nominal force [N]
p.tyre1.kz   =  109000;        % Tyre vertical stiffness [N/m]
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

%tyre spec
tyre.width = 0.05; %tyre width (m)
tyre.dia = 0.5; %tyre diameter (m)
tyre.miua = 0.7; %tyre friction coefficient
tyre.load = 0.7; %rear axle load coeffcient
tyre.rwd = 0.98*tyre.dia; %tyre diameter under load

%{
temp = numel(raceTrackXY(:,1));
%generate vector one step ahead of u
for i = 2:(temp - 1)   
        v(i,:) = u((i-1),:);
end
%clean up vectors and add temp z data
v(1,:) = u(temp-1,:);
u = cat(2,u,a);
v = cat(2,v,a);
%initialise array for angle
angleTheta = zeros((temp - 1),1);
%generate angles 
for i = 1:temp-1
    angleTheta(i) = subspace(u(i,:)', v(i,:)');
    %angleTheta(i) = angleTheta(i)*57.2958; %convert to degrees
end

%plot(linspace(0,4206,numel(angleTheta)),angleTheta)

%find radius of curvature
%initialise array
cornerRadii = zeros(numel(raceTrackXY(:,1))-2,1);

for i = 1:(numel(raceTrackXY(:,1))-2)
    ma = (raceTrackXY(i+1,2) - raceTrackXY(i,2))/(raceTrackXY(i+1,1) - raceTrackXY(i,1));
    mb = (raceTrackXY(i+2,2) - raceTrackXY(i+1,2))/(raceTrackXY(i+2,1) - raceTrackXY(i+1,1));
    circleXCoord = (ma*mb*(raceTrackXY(i,2) - raceTrackXY(i+2,2)) + mb*(raceTrackXY(i,1) + raceTrackXY(i+1,1)) - ma*(raceTrackXY(i+1,1) + raceTrackXY(i+2,1)))/(2*(mb-ma));
    circleYCoord = ma*(circleXCoord - raceTrackXY(i,1)) + raceTrackXY(i,2);
    cornerRadii(i) = sqrt((raceTrackXY(i,1) - circleXCoord)^2 + (raceTrackXY(i,2) - circleYCoord)^2);
end

for i = 1:(numel(raceTrackXY(:,1))-2)
    matrixA = [raceTrackXY(i,1), raceTrackXY(i,2), 1;raceTrackXY(i+1,1), raceTrackXY(i+1,2), 1;raceTrackXY(i+2,1), raceTrackXY(i+2,2), 1;];
    matrixB = - [(raceTrackXY(i,1)^2 + raceTrackXY(i,2)^2), raceTrackXY(i,2), 1; (raceTrackXY(i,1)^2 + raceTrackXY(i+1,2)^2), raceTrackXY(i+1,2), 1; (raceTrackXY(i+2,1)^2 + raceTrackXY(i+2,2)^2), raceTrackXY(i+2,2), 1; ];
    matrixC = - [(raceTrackXY(i,1)^2 + raceTrackXY(i,2)^2), raceTrackXY(i,1), 1; (raceTrackXY(i,1)^2 + raceTrackXY(i+1,2)^2), raceTrackXY(i+1,1), 1; (raceTrackXY(i+2,1)^2 + raceTrackXY(i+2,2)^2), raceTrackXY(i+2,1), 1; ];
    matrixD = - [(raceTrackXY(i,1)^2 + raceTrackXY(i,2)^2), raceTrackXY(i,1), raceTrackXY(i,2); (raceTrackXY(i,1)^2 + raceTrackXY(i+1,2)^2), raceTrackXY(i+1,1), raceTrackXY(i+1,2); (raceTrackXY(i+2,1)^2 + raceTrackXY(i+2,2)^2), raceTrackXY(i+2,1), raceTrackXY(i+2,2); ];
    A = det(matrixA);
    B = det(matrixB);
    C = det(matrixC);
    D = det(matrixD);
    cornerRadii(i) = sqrt((B^2 + C^2 - 4*A*D)/4*A^2);
end
cornerRadii = cat(1,cornerRadii(1),cornerRadii);
cornerRadii = cat(1,cornerRadii,cornerRadii(numel(cornerRadii)));

%track length
%initialise vars
trackLength = zeros(numel(raceTrackXY(:,1))-1,1);
for i = 1:(numel(raceTrackXY(:,1)) -1)
    L = sqrt((raceTrackXY(i+1,1) - raceTrackXY(i,1))^2 + (raceTrackXY(i+1,2) - raceTrackXY(i,2))^2);
    trackLength(i+1) = trackLength(i)+ L;
end

trackLengthTemp = trackLength;
trackLengthTemp(end,:) = [];

%track curvature with length of track
TCL = cat(2,cornerRadii,trackLength);
ATwL = cat(2,angleTheta,trackLengthTemp); 
%}
