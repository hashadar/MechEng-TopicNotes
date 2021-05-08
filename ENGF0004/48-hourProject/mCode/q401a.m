clc
clear
close all

%import data
rest = readmatrix('Section4_data.xlsx', 'Range', 'A2:A39');
anti = readmatrix('Section4_data.xlsx', 'Range', 'B2:B43');

nRest = numel(rest); %number of elements
nAnti = numel(anti);

muRest = mean(rest); %mean 
muAnti = mean(anti);

sigmaRest = std(rest); % sample standard deviation 
sigmaAnti = std(anti);