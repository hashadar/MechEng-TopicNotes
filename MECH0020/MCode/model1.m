clc
clear
close all

%motor parameters
motor.NMaxTq = 3500; %motor speed for max torque (rpm)
motor.NMaxPwr = 6500; %motor speed for max power (rpm)
motor.tqFullLoad = [500 500 500 500 500 500]; %motor torque curve at full load (Nm)
motor.NtqFullLoad = linspace(0,10000,6); %motor speed axis (rpm)
motor.Nmax = 10000; %max motor speed (rpm)
motor.Nmin = 0; %min motor speed (rpm)

%transmission
gearbox.gearMin = 1; %lowest gear
gearbox.gearMax = 8; %highest gear
gearbox.gearRatio = [3 2 1 0.8]; %gear ratios
gearbox.i0 = 2; %final drive ratio at the differential
gearbox.effic = 0.9; %drivetrain efficiency

%tyre spec
tyre.width = 0.2; %tyre width (m)
tyre.dia = 10*0.02; %tyre diameter (m)
tyre.miua = 1.1; %tyre friction coefficient
tyre.load = 0.7; %rear axle load coeffcient
tyre.rwd = 0.98*tyre.dia; %tyre diameter under load

%vehicle
veh.curbMass = 200; %curb mass (kg)
veh.driverMass = 60; %driver mass (kg)
veh.massFactor = 1.05; %mass factor
veh.g = 9.81; %grav constant (m/s^2)
veh.cd = 0.2; %drag coefficient
veh.fa = 2; %frontal area (m^2)
veh.rho = 1.202; %air density (kg/m^3)
road.cr = 0.011; %road load coefficient
veh.mass = veh.curbMass*veh.massFactor + veh.driverMass;
%motor torque and motor power curves

motor.powerFullLoad = linspace(0,100,5);
motor.tqFullLoad = linspace(500,500,5);