%HD
clc
clear
set(0,'DefaultLineLineWidth',1)
set(0,'DefaultLineMarkerSize',8)

data = readmatrix('MeshConvergence.xlsx');
data2 = readmatrix('MeshConvergence.xlsx','Sheet','Sheet3');

cellCount = data(1:12,4);
VMag1 = data(1:12,6);
VMag2 = data(1:12,11);
P1 = data(1:12,7);
P2 = data(1:12,12);
compTime = data(1:12,8);
compTime = compTime./60;

Strain1 = cat(2,data2(:,1),data2(:,2));
Strain2 = cat(2,data2(:,3),data2(:,4));

percDiffVMag1 = zeros(numel(VMag1)-1,1);
for i = 1:numel(cellCount) - 1
    percDiffVMag1(i) = (VMag1(i+1)-VMag1(i))/(VMag1(i))*100;
end

percDiffVMag2 = zeros(numel(VMag1)-1,1);
for i = 1:numel(cellCount) - 1
    percDiffVMag2(i) = (VMag2(i+1)-VMag2(i))/(VMag2(i))*100;
end

percDiffP1 = zeros(numel(P1)-1,1);
for i = 1:numel(cellCount) - 1
    percDiffP1(i) = (P1(i+1)-P1(i))/(P1(i))*100;
end

percDiffP2 = zeros(numel(P1)-1,1);
for i = 1:numel(cellCount) - 1
    percDiffP2(i) = (P2(i+1)-P2(i))/(P2(i)*100);
end
%{
semilogx(cellCount(2:12,1),percDiffVMag1,'-x red',cellCount(2:12,1),percDiffVMag2,'-o green',cellCount(2:12,1),percDiffP1,'-+ blue',cellCount(2:12,1),percDiffP2,'-* black')
grid on
xlabel('Cell Count')
ylabel('Percentage change from previous simulation')
xlim([0.9*cellCount(2,1),1.1*cellCount(end,1)])
legend('% difference in velocity at point A', '% difference in pressure at point A', '% difference in velocity at point B', '% difference in pressure at point B')
%}

%{
plot(cellCount,compTime,'-x black')
grid on
xlabel('Cell Count')
ylabel('Time taken for solver to complete/min')
%}

plot(1000*Strain1(:,1),Strain1(:,2),'- red',1000*Strain2(:,1),Strain2(:,2),'- blue');
grid on
xlabel('x-coordinate/mm')
ylabel('Strain rate/ [s^{-1}]')
legend('Coiled','Uncoiled')