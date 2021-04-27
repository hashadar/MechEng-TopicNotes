clc
clear
close all

%import data
data = readmatrix('Section3_data.txt');

y = fft(data(:,2)); %compute discrete Fourier transform of data, (fast Fourier transform algorithim), indexing pulse oximeter data
n = length(data(:,2)); %find length of matrix
Fs = 10; % Sampling frequency (Hz) 
f =(0:n-1)*(Fs/n); % Frequency range 
fshift = (-n/2:n/2-1)*(Fs/n); %defines x-axis range for shifted transform
yshift = fftshift(y); %shifts zero-frequency component to centre of the array, this swaps the left and the right halves of x
figure;

%plot data
plot(fshift, abs(yshift))
title('Graph to show absolute values of transform in the frequency domain')
xlabel('Frequency/Hz')
ylabel('Fourier transform of signal data/arbitrary units')
axis square
grid on