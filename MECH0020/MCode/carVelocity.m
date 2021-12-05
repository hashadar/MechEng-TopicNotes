%HD

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
    angleTheta(i) = angleTheta(i)*57.2958; %convert to degrees
end

plot(linspace(0,4206,numel(angleTheta)),angleTheta)

%8m radius

%mass of system
mVeh = 200; %mass of vehicle (kg)
mDriver = 65; %mass of driver (kg)
JWheel = 21; %moment of inertia wheel (kgm^2)
RWheel = 0.3; %wheel radius (m)

mCar = mVeh + mDriver + (3*JWheel)/(RWheel^2);

%traction force
nTr = 0.9; %transmission efficiency
TM = 100; %motor torque (Nm)
tauT = 1; %transmission ratio

Fm = (nTr*TM)/(tauT*RWheel);

%aero drag
rho = 1000; %air density (kg/m^3)
A = 1; %frontal cross-section (m^2)
Cx = 0.2; %drag coefficient 
%v = 1; %velocity

%Fd = 0.5*rho*A*Cx*v^2;

%grade resistance
g = 9.81; %gravitational constant


