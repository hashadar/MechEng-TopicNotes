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
z = [gaussmf(fshift, [0.01 1.2])' + gaussmf(fshift, [0.01 -1.2])'];%generate and add gaussians
filtData = yshift.*z; %multiply FT signal data with gaussian
y2 = ifftshift(filtData); %inverse zero frequency shift
x2 = ifft(y2); %inverse fourier
figure;

%plot data
plot(data(:,1), x2)
title('Graph to show filtered data from pulse oximeter')
xlabel('Time/s')
ylabel('Pulse oximeter signal/arbitrary units')
axis auto
grid on