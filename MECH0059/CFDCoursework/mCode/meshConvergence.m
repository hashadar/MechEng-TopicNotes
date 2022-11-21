%HD
clc
clear

data = readmatrix('MeshConvergence.xlsx');

cellCount = data(1:12,3);
VMag1 = data(1:12,5);
VMag2 = data(1:12,10);
P1 = data(1:12,6);
P2 = data(1:12,11);
compTime = data(1:12,7);
compTime = compTime./60;

percDiffVMag1 = zeros(numel(VMag1)-1,1);
for i = 1:numel(cellCount) - 1
    percDiffVMag1(i) = (VMag1(i+1)-VMag1(i))/(VMag1(i));
end

percDiffVMag2 = zeros(numel(VMag1)-1,1);
for i = 1:numel(cellCount) - 1
    percDiffVMag2(i) = (VMag2(i+1)-VMag2(i))/(VMag2(i));
end

percDiffP1 = zeros(numel(P1)-1,1);
for i = 1:numel(cellCount) - 1
    percDiffP1(i) = (P1(i+1)-P1(i))/(P1(i));
end

percDiffP2 = zeros(numel(P1)-1,1);
for i = 1:numel(cellCount) - 1
    percDiffP2(i) = (P2(i+1)-P2(i))/(P2(i));
end

semilogx(cellCount(2:12,1),percDiffVMag1,cellCount(2:12,1),percDiffVMag2,cellCount(2:12,1),percDiffP1,cellCount(2:12,1),percDiffP2)
%plot(cellCount,compTime,'x')
grid on