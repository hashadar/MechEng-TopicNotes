clc
clear
close all

%import data
data = readmatrix('data.xlsx');

%linear regression of elastic region
x = data(1:15,1); %engineeringStrain, first 15 elements of data represent elastic region
y = data(1:15,2); %engineeringStressMPa
format long
YM = x\y;
yCalc1 = YM*x; %slope - YM

%plot data (check YM)
plot(data(:,1),data(:,2))
hold on
%plot(x, yCalc1)

%yield point offset
x1 = x + 0.002; %0.2% offset method
extrapRange = linspace(0.002,0.004,numel(data(:,1))-numel(x))'; %x-values to extrap over
yCalc2 = interp1(x1, yCalc1, extrapRange, 'linear', 'extrap'); %extra calc
x2 = cat(1,x1,extrapRange); %cat arrays
yCalc3 = cat(1,yCalc1,yCalc2);
%plot(x2,yCalc3) %check
[yieldPointEngi, yieldPointEngj] = polyxpoly(x2, yCalc3, data(:,1), data(:,2));


%eng UTS
[~, engindexStress] = max(data); %find max value in array cols
engUTSStress = data(engindexStress(2),2); %max eng stress
engUTSStrain = data(engindexStress(2),1); %max eng strain

%true stress strain
%initialise arrays
n = numel(data(:,1));
trueStress = zeros(n,1);
trueStrain = zeros(n,1);
for i = 1:n
    trueStress(i) = data(i,2)*exp(data(i,1)); %true stress calc
    trueStrain(i) = log(1 + data(i,1)); %true strain calc
end
%check
plot(trueStrain,trueStress)

%true UTS
[temp, trueIndexStress] = max(trueStress); %find max value in array cols
trueUTSStress = trueStress(trueIndexStress); %max true stress
trueUTSStrain = trueStrain(trueIndexStress); %max true strain

%effective stress-strain
%calc effective stress vals
effectiveStrain = trueStrain;
n = numel(trueStrain);
effectiveStress = trueStress;
for i = engindexStress(2):n
    effectiveStress(i) = engUTSStress*(1 + data(i,1));
end
plot(effectiveStrain, effectiveStress)
xlabel('Strain')
ylabel('Stress/MPa')
grid on
title('Graph to show engineering vs true vs effective stress-strain of material')
legend('Engineering', 'True', 'Effective')
hold off

%true plastic strain / ABAQUS input data
%find yield point true
[yieldPointTruei, yieldPointTruej] = polyxpoly(x2, yCalc3, trueStrain, trueStress); %find yield point true
[~,idx]=min(abs(effectiveStress - yieldPointTruej)); %index yield point
n = numel(effectiveStress)-idx; %intialise index 
plasticYield = zeros(n -idx,2); %intialise array
for i = 1:n
    plasticYield(i,2) = effectiveStress(i+idx-1); %plastic stress
    plasticYield(i,1) = effectiveStrain(i+idx-1) - yieldPointTruei; %plastic strain
end
plasticYield(1,1) = 0;