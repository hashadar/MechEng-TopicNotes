clc
clear
close all
%import data
data = readmatrix('Section3_data.txt');

y = fft(data(:,2)); %compute discrete Fourier transform of data, (fast Fourier transform algorithim), indexing pulse oximeter data
n = length(data(:,2)); %find length of matrix
Fs = 10; % Sampling frequency (Hz) 
fshift = (-n/2:n/2-1)*(Fs/n); %defines x-axis range for shifted transform
z = [normpdf(fshift, 1.2, 0.01)' + normpdf(fshift, -1.2, 0.01)'];%generate and add gaussians

%plot data 
plot(fshift, z)
title('Graph to show filter, centred at positive and negative cardiac frequencies')
axis square;
grid on
xlabel('Frequency/Hz')
ylabel('Magnitude/arbritrary units')