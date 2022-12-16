%HD

clc
clear
close all

%import data
data = readmatrix('data.xlsx','Sheet','Expansion loop','Range','A4:P23');
elSize = [0.5;0.25;0.125;0.1;0.075;0.05;0.025;0.01];

%array initialise
A = zeros(numel(data(:,1)),numel(data(1,:))/2);

%calculate percentage difference of result compared to 0.01m el size
for i = 1:numel(elSize)
    for j = 1:numel(data(:,1))
        A(j,i) = 100*(data(j,i*2) - data(j,end))/data(j,end);
    end
end

%plot
for i = 1:numel(A(:,1))
    plot(A(i,:))
    hold on
end
xticklabels(elSize);
grid on
axis auto
xlabel('Element size/m');
ylabel('Percentage difference of modal frequency/%');
title('Graph to show mesh sensitivity of expansion loop')
hold off