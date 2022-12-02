%HD
clc
clear 

%import data
data = readmatrix('data5');

%split data
%line voltages
V_A = cat(2,data(:,1),data(:,2));
V_B = cat(2,data(:,1),data(:,4));
V_C = cat(2,data(:,1),data(:,6));

%line currents
I_A = cat(2,data(:,1),data(:,3));
I_B = cat(2,data(:,1),data(:,5));
I_C = cat(2,data(:,1),data(:,7));

%graph plotting
%{
plot(V_A(:,1),V_A(:,2),'black',...
    V_B(:,1),V_B(:,2),'red',...
    V_C(:,1),V_C(:,2),'blue')
xlim([0.45,0.65])
grid on
xlabel('Time/s')
ylabel('Voltage/kV')
legend('A phase','B phase','C phase')
%}

plot(I_A(:,1),I_A(:,2),'black',...
    I_B(:,1),I_B(:,2),'red',...
    I_C(:,1),I_C(:,2),'blue')
xlim([0.45,0.65])
grid on
xlabel('Time/s')
ylabel('Current/kA')
legend('A phase','B phase','C phase')
