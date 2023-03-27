%% HD

clc
clear
close all

%% import data

topx = readmatrix('top-x-displacement-nodal.txt');
topy = readmatrix('top-y-displacement-nodal.txt');
botx = readmatrix('bot-x-displacement-nodal.txt');
boty = readmatrix('bot-y-displacement-nodal.txt');
% step | time | min m | max m | avg m

topx(1,:) = [];
topy(1,:) = [];
botx(1,:) = [];
boty(1,:) = [];

%% plots
% setup
sz = 50;
c = linspace(-160-22,240-22,21);
darkblue = [0,0,255];
brightred = [238,75,43];
colour = [linspace(darkblue(1,1),brightred(1,1),21)',...
    linspace(darkblue(1,2),brightred(1,2),21)',...
    linspace(darkblue(1,3),brightred(1,3),21)']/256;
% x-y deformation top bend
scatter(topx(:,5),topy(:,5),sz,c,'filled');
% settings
colormap(colour);
colorHandle = colorbar();
a=colorbar;
a.Location = 'southoutside';
a.Direction = 'reverse';
a.Label.String = ['Temperature T-T_0/' char(176) 'C'];
hColourbar.Label.Position(1) = 50;
a.Ticks = c; 
a.TickLabels = num2cell(c); 
grid on
xlabel('Deformation x-axis/m');
ylabel('Deformation y-axis/m');

%{
plot(topx(:,4),topy(:,4))
axis equal
xlim([-10e-3,10e-3])
ylim([-0.05,0.05])
%}