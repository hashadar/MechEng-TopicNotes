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

%plot(linspace(0,4206,numel(angleTheta)),angleTheta)

%define time
t = linspace(0,10,0.01)';

%motor parameters
motor.NMaxTq = 0; %motor speed for max torque (rpm)
motor.NMaxPwr = 500; %motor speed for max power (rpm)
motor.MaxPower = 1000; %motor max rated power (W)
motor.MaxTorque = 10; %motor rated torque (Nm)
motor.NtqFullLoad = linspace(0,1000,100); %motor speed axis (rpm)
motor.tqFullLoad = [linspace(0,100,100); linspace(10,0,100)]'; %motor torque curve at full load (Nm)
motor.Nmax = 1000; %max motor speed (rpm)
motor.Nmin = 0; %min motor speed (rpm)
for i = 1:numel(motor.NtqFullLoad)
    motor.pwrFullLoad(i) = -(motor.MaxTorque/motor.Nmax)*(motor.NtqFullLoad(i))^2 + motor.MaxTorque*motor.NtqFullLoad(i);
end

%transmission
gearbox.i0 = 5; %final drive ratio at the differential
gearbox.effic = 0.9; %drivetrain efficiency

%tyre spec
tyre.width = 0.05; %tyre width (m)
tyre.dia = 0.5; %tyre diameter (m)
tyre.miua = 0.7; %tyre friction coefficient
tyre.load = 0.7; %rear axle load coeffcient
tyre.rwd = 0.98*tyre.dia; %tyre diameter under load

%vehicle
veh.curbMass = 100; %curb mass (kg)
veh.driverMass = 60; %driver mass (kg)
veh.massFactor = 1.05; %mass factor
veh.g = 9.81; %grav constant (m/s^2)
veh.cd = 0.1; %drag coefficient
veh.fa = 0.5; %frontal area (m^2)
veh.rho = 1.225; %air density (kg/m^3)
road.cr = 0.011; %road load coefficient
veh.mass = veh.curbMass*veh.massFactor + veh.driverMass;
road.slope = 0; 

input = 1000;