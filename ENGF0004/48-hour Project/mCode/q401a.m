clc
clear
close all

%import data
rest = readmatrix('Section4_data.xlsx', 'Range', 'A2:A39');
anti = readmatrix('Section4_data.xlsx', 'Range', 'B2:B43');

muRest = mean(rest);
muAnti = mean(anti);