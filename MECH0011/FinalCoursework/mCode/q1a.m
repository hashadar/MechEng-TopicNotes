clc
clear
close all

%define vars
i = ["EPPLER 818 Hydrofoil", "NACA 63-412 Aifoil", "RG 8 Airfoil", "YS 930 Hydrofoil"]; %index hydrofoil names from sheets for ease
data = zeros(122,2,4); %initialise matrix
counter = 0; %initialise counter 
x = linspace(0,1,100); %interpolation range initialisation

%import data
for j = 1:4 %index all data for plots
    counter = counter + 1; %increment counter
    data(:,:,counter) = readmatrix('suppFiles.xlsx','Sheet',i(j),'Range','A3:B124'); %loop through sheets and pull data
end

%camber line calculation
%pull positive and negative coordinate points
%eppler
dataPos1 = readmatrix('suppFiles.xlsx','Sheet',i(1),'Range','A3:B37');
dataNeg1 = readmatrix('suppFiles.xlsx','Sheet',i(1),'Range','A38:B70');

%naca
dataPos2 = readmatrix('suppFiles.xlsx','Sheet',i(2),'Range','A3:B28');
dataNeg2 = readmatrix('suppFiles.xlsx','Sheet',i(2),'Range','A29:B54');

%rg
dataPos3 = readmatrix('suppFiles.xlsx','Sheet',i(3),'Range','A3:B34');
dataNeg3 = readmatrix('suppFiles.xlsx','Sheet',i(3),'Range','A35:B64');

%ys
dataPos4 = readmatrix('suppFiles.xlsx','Sheet',i(4),'Range','A3:B65');
dataNeg4 = readmatrix('suppFiles.xlsx','Sheet',i(4),'Range','A66:B124');

%interpolate hydrofoil shape with 100 data points from 0 to 1
%eppler
dataIntPos1 = interp1(dataPos1(:,1), dataPos1(:,2), x);
dataIntNeg1 = interp1(dataNeg1(:,1), dataNeg1(:,2), x);

%naca
dataIntPos2 = interp1(dataPos2(:,1), dataPos2(:,2), x);
dataIntNeg2 = interp1(dataNeg2(:,1), dataNeg2(:,2), x);

%rg
dataIntPos3 = interp1(dataPos3(:,1), dataPos3(:,2), x);
dataIntNeg3 = interp1(dataNeg3(:,1), dataNeg3(:,2), x);

%ys
dataIntPos4 = interp1(dataPos4(:,1), dataPos4(:,2), x);
dataIntNeg4 = interp1(dataNeg4(:,1), dataNeg4(:,2), x);

%calculate camber line
%eppler
camber1 = (dataIntPos1 + dataIntNeg1)./2;

%naca
camber2 = (dataIntPos2 + dataIntNeg2)./2;

%rg
camber3 = (dataIntPos3 + dataIntNeg3)./2;

%ys
camber4 = (dataIntPos4 + dataIntNeg4)./2;

%plot data
subplot(4,1,1)
plot(dataPos1(:,1), dataPos1(:,2),'b',dataNeg1(:,1), dataNeg1(:,2),'b', x, camber1,'r')
axis image
grid on
xlabel('Chord')
ylabel('Z(x)')
title('Plot of ' + i(1))
xlim([-0.05 1.05])
ylim([-0.05 0.1])
legend('Hydrofoil profile','Mean camber line')

subplot(4,1,2)
plot(dataPos2(:,1), dataPos2(:,2),'b',dataNeg2(:,1), dataNeg2(:,2),'b', x, camber2,'r')
axis image
grid on
xlabel('Chord')
ylabel('Z(x)')
title('Plot of ' + i(2))
xlim([-0.05 1.05])
ylim([-0.05 0.1])
legend('Hydrofoil profile','Mean camber line')

subplot(4,1,3)
plot(dataPos3(:,1), dataPos3(:,2),'b',dataNeg3(:,1), dataNeg3(:,2),'b', x, camber3,'r')
axis image
grid on
xlabel('Chord')
ylabel('Z(x)')
title('Plot of ' + i(3))
xlim([-0.05 1.05])
ylim([-0.05 0.1])
legend('Hydrofoil profile','Mean camber line')

subplot(4,1,4)
plot(dataPos4(:,1), dataPos4(:,2),'b',dataNeg4(:,1), dataNeg4(:,2),'b', x, camber4,'r')
axis image
grid on
xlabel('Chord')
ylabel('Z(x)')
title('Plot of ' + i(4))
xlim([-0.05 1.05])
ylim([-0.05 0.1])
legend('Hydrofoil profile','Mean camber line')