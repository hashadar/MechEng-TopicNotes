clc
clear
close all

%import data
T = readmatrix('q3Data.xlsx');

%auto calcs
meanA = mean(T(:,4)); %mean 
meanB = mean(T(:,8)); 

stdA = std(T(:,4)); %standard deviation 
stdB = std(T(:,8)); 

%manual calcs
muA = sum(T(:,4))/numel(T(:,4)); %find mean 
muB = sum(T(:,8))/numel(T(:,8));

meanDiffA = T(:,4) - muA; %find difference between value and mean
meanDiffB = T(:,8) - muB;

squareSumDiffA = sum(meanDiffA.^2); %square and sum 
squareSumDiffB = sum(meanDiffB.^2);

stanDevA = sqrt(squareSumDiffA/(numel(T(:,4))-1)); %square root and divide by n-1 (sample)
stanDevB = sqrt(squareSumDiffB/(numel(T(:,8))-1));

%check
if meanA == muA && meanB == muB && stdA == stanDevA && stdB == stanDevB
    disp('correct')
else
    disp('try again')
end