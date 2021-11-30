%HD

clc
clear
close all

%define sheets to pull data
meshTypes = ["LinearQuad0.01" "LinearQuad0.005", "LinearQuad0.0021", "LinearTri0.01", "LinearTri0.005", "QuadQuad0.01", "QuadQuad0.005", "QuadTri0.01", "QuadTri0.005"];

%initialise matrices
bs11 = zeros(101,2,numel(meshTypes));
bs22 = zeros(101,2,numel(meshTypes));
bs12 = zeros(101,2,numel(meshTypes));
ds11 = zeros(101,2,numel(meshTypes));
ds22 = zeros(101,2,numel(meshTypes));
ds12 = zeros(101,2,numel(meshTypes));
ls11 = zeros(101,2,numel(meshTypes));
ls22 = zeros(101,2,numel(meshTypes));
ls12 = zeros(101,2,numel(meshTypes));

%assign values
sigma1 = 1000;
sigma2 = 400;
theta = pi/2;
a = 0.1;

%initialise space matrices
r = linspace(0.1,1,1000);
r2 = linspace(0,0.9,1000);
r3 = linspace(0.1,0.9,101);
r4 = linspace(0.1, 1.4142, 101);

%pull data + calc SCF
for i = 1:numel(meshTypes)
    bs11(:,:,i) = readmatrix('dataImport.xlsx','Sheet', meshTypes(i),'Range', 'A2:B102');
    bs11(:,2,i) = bs11(:,2,i)*(1/sigma1);
    bs22(:,:,i) = readmatrix('dataImport.xlsx','Sheet', meshTypes(i),'Range', 'C2:D102');
    bs22(:,2,i) = bs22(:,2,i)*(1/sigma1);
    bs12(:,:,i) = readmatrix('dataImport.xlsx','Sheet', meshTypes(i),'Range', 'E2:F102');
    bs12(:,2,i) = bs12(:,2,i)*(1/sigma1);
    ds11(:,:,i) = readmatrix('dataImport.xlsx','Sheet', meshTypes(i),'Range', 'G2:H102');
    ds11(:,2,i) = ds11(:,2,i)*(1/sigma1);
    ds22(:,:,i) = readmatrix('dataImport.xlsx','Sheet', meshTypes(i),'Range', 'I2:J102');
    ds22(:,2,i) = ds22(:,2,i)*(1/sigma1);
    ds12(:,:,i) = readmatrix('dataImport.xlsx','Sheet', meshTypes(i),'Range', 'K2:L102');
    ds12(:,2,i) = ds12(:,2,i)*(1/sigma1);
    ls11(:,:,i) = readmatrix('dataImport.xlsx','Sheet', meshTypes(i),'Range', 'M2:N102');
    ls11(:,2,i) = ls11(:,2,i)*(1/sigma1);
    ls22(:,:,i) = readmatrix('dataImport.xlsx','Sheet', meshTypes(i),'Range', 'O2:P102');
    ls22(:,2,i) = ls22(:,2,i)*(1/sigma1);
    ls12(:,:,i) = readmatrix('dataImport.xlsx','Sheet', meshTypes(i),'Range', 'Q2:R102');
    ls12(:,2,i) = ls12(:,2,i)*(1/sigma1);
end

%numerical
sigmaTheta = ((sigma2 + sigma1)/(2)).*(1 + (a^2)./(r.^2)) - ((sigma2 - sigma1).*(cos(2*theta)).*(1 + (3*(a^4))./(r.^4)));
sigmaTheta = sigmaTheta.*(1/sigma1);

%plot(r3, bs11(:,2,7), r4, ds11(:,2,7), r3, ls11(:,2,7));
%plot(r3, bs22(:,2,7), r4, ds22(:,2,7), r3, ls22(:,2,7));
plot(r3, bs22(:,2,7), r, sigmaTheta);
%title("Graph to show $$\frac{\tau_{r\theta}}{\sigma_1}-r$$ for $$\theta = 0, \frac{\pi}{4}, \frac{\pi}{2}$$", 'interpreter','latex')
title("Graph to show $$\frac{\tau_{r\theta}}{\sigma_1}-r$$ for $$\theta = 0$$", 'interpreter','latex')
xlabel("Distance along path/m")
ylabel("SCF")
grid on
hold off
%legend("Bottom", "Diagonal", "Left")