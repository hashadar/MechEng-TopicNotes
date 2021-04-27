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
z = [normpdf(fshift, 1.2, 0.01)' + normpdf(fshift, -1.2, 0.01)'];%generate and add gaussians
filtData = abs(yshift).*z; %multiply FT signal data with gaussian
figure;

%plot data
plot(fshift, filtData, fshift, abs(yshift))
title('Graph to show comparison between filtered and unfiltered FT signal')
xlabel('Frequency/Hz')
ylabel('Fourier transform of signal data/arbitrary units')
legend('Filtered data', 'Unfiltered data')
axis square
grid on
figure(2);
plot(fshift, filtData, fshift, abs(yshift))
xlim([1 2])
ylim([0 150])
title('Graph to show comparison between filtered and unfiltered FT signal')
xlabel('Frequency/Hz')
ylabel('Fourier transform of signal data/arbitrary units')
legend('Filtered data', 'Unfiltered data')
axis square
grid on