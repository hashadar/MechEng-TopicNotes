clc
clear
close all

%import data
data = readmatrix('suppFiles.xlsx','Sheet','Boundary Layer','Range','A2:B102');

%setup data and vars
var1 = 1 - data(:,1);
var2 = data(:,1).*(1-data(:,1));
dispThick = zeros(1,100);
momThick = zeros(1,100);

%displacement thickness integral
for i = 1:100 %hundred strips
    dispThick(i) = ((var1(i,1)) + (var1(i+1,1)))*(1/100)/2; %calc area of trapezium and store
end
momThickInt = sum(dispThick); %sum values to find integral

%momentum thickness integral
for i = 1:100
    momThick(i) = ((var2(i,1)) + (var2(i+1,1)))*(1/100)/2;
end
dispThickInt = sum(momThick);

%calc shape factor
H = momThickInt/dispThickInt;

