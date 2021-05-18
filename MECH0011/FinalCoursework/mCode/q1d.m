clc
clear
close all

%define vars
i = ["EPPLER 818 Hydrofoil", "NACA 63-412 Aifoil", "RG 8 Airfoil", "YS 930 Hydrofoil"]; %index hydrofoil names from sheets for ease
x = linspace(0,1,100); %interpolation range initialisation

%max percentage camber line calculation
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

%maximum camber per hydrofoil
%eppler
percCamber1 = max(camber1);

%naca
percCamber2 = max(camber2);

%rg
percCamber3 = max(camber3);

%ys
percCamber4 = max(camber4);

%clean-up output
percCamber = 100.*[percCamber1 percCamber2 percCamber3 percCamber4];

%maximum percentage thickness calculation
%eppler
thickness1 = (abs(dataIntPos1) + abs(dataIntNeg1));

%naca
thickness2 = (abs(dataIntPos2) + abs(dataIntNeg2));

%rg
thickness3 = (abs(dataIntPos3) + abs(dataIntNeg3));

%ys
thickness4 = (abs(dataIntPos4) + abs(dataIntNeg4));

%max thickness per hydrofoil
%eppler
maxThick1 = max(thickness1);

%naca
maxThick2 = max(thickness2);

%rg
maxThick3 = max(thickness3);

%ys
maxThick4 = max(thickness4);

%clean-up output
maxThick = 100.*[maxThick1 maxThick2 maxThick3 maxThick4];

%maximum lift coefficient
%pull angle of attack, cl and cd from data
%eppler
epplerData = readmatrix('suppFiles.xlsx','Sheet',i(1),'Range','D2:F79');

%naca
nacaData = readmatrix('suppFiles.xlsx','Sheet',i(2),'Range','D2:F107');

%rg
rgData = readmatrix('suppFiles.xlsx','Sheet',i(3),'Range','D2:F101');

%ys
ysData = readmatrix('suppFiles.xlsx','Sheet',i(4),'Range','D2:F78');

%find max cl
%eppler
maxEpplerCL = max(epplerData(:,2));

%naca
maxNacaCL = max(nacaData(:,2));

%rg
maxRgCL = max(rgData(:,2));

%ys
maxYsCL = max(ysData(:,2));

%clean-up output
maxCL = [maxEpplerCL maxNacaCL maxRgCL maxYsCL];

%find angle of attack at max cl
%eppler
critEppler = epplerData(epplerData(:,2) == maxEpplerCL,1);

%naca
critNaca = nacaData(nacaData(:,2) == maxNacaCL,1);

%rg
critRg = rgData(rgData(:,2) == maxRgCL,1);

%ys
critYs = ysData(ysData(:,2) == maxYsCL,1);

%clean-up output
crit = [critEppler critNaca critRg critYs];

%lift coefficient for alpha = 0
%eppler 
liftAlpha0Eppler = epplerData(epplerData(:,1) == 0,2);

%naca
liftAlpha0Naca = nacaData(nacaData(:,1) == 0,2);

%rg
liftAlpha0Rg = rgData(rgData(:,1) == 0,2);

%ys
liftAlpha0Ys = ysData(ysData(:,1) == 0,2);

%clean-up output
liftAlpha0 = [liftAlpha0Eppler liftAlpha0Naca liftAlpha0Rg liftAlpha0Ys];

%angle of attack corresponding to cl = 0
%find min cl
%eppler
minEpplerCL = min(epplerData(:,2));

%naca
minNacaCL = min(nacaData(:,2));

%rg
minRgCL = min(rgData(:,2));

%ys
minYsCL = min(ysData(:,2));

%find angle of attack at min cl
%eppler
AOAMinEppler = epplerData(epplerData(:,2) == minEpplerCL,1);

%naca
AOAMinNaca = nacaData(nacaData(:,2) == minNacaCL,1);

%rg
AOAMinRg = rgData(rgData(:,2) == minRgCL,1);

%ys
AOAMinYs = ysData(ysData(:,2) == minYsCL,1);

%clean-up output
AOAMin = [AOAMinEppler AOAMinNaca AOAMinRg AOAMinYs];

%generate table
T = table(i', percCamber', maxThick', maxCL', crit', liftAlpha0', AOAMin');
