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
z1 = [gaussmf(fshift, [0.01 1.2])' + gaussmf(fshift, [0.01 -1.2])'];%generate and add gaussians
z2 = [gaussmf(fshift, [0.1 1.2])' + gaussmf(fshift, [0.1 -1.2])'];%generate and add gaussians
z3 = [gaussmf(fshift, [0.001 1.2])' + gaussmf(fshift, [0.001 -1.2])'];%generate and add gaussians
filtData1 = yshift.*z1; %multiply FT signal data with gaussian 0.1
filtData2 = yshift.*z2; %multiply FT signal data with gaussian 0.01
filtData3 = yshift.*z3; %multiply FT signal data with gaussian 0.001
y21 = ifftshift(filtData1); %inverse zero frequency shift 0.1
x21 = ifft(y21); %inverse fourier
y22 = ifftshift(filtData2); %inverse zero frequency shift 0.01
x22 = ifft(y22); %inverse fourier
y23 = ifftshift(filtData3); %inverse zero frequency shift 0.001
x23 = ifft(y23); %inverse fourier
figure;

%plot data
subplot(2,2,1)
plot(fshift, abs(yshift))
title('unfiltered')
xlim([0.7 1.7])
ylim([0 150])
xlabel('Magnitude')
ylabel('Frequency/Hz')
axis square
grid on
subplot(2,2,2)
plot(fshift, abs(filtData2))
title('stdev = 0.1')
xlim([0.7 1.7])
ylim([0 150])
xlabel('Magnitude')
ylabel('Frequency/Hz')
axis square
grid on
subplot(2,2,3)
plot(fshift, abs(filtData1))
xlim([0.7 1.7])
ylim([0 150])
xlabel('Magnitude')
ylabel('Frequency/Hz')
title('stdev = 0.01')
axis square
grid on
subplot(2,2,4)
plot(fshift, abs(filtData3))
xlim([0.7 1.7])
ylim([0 150])
xlabel('Magnitude')
ylabel('Frequency/Hz')
title('stdev = 0.001')
axis square
grid on

figure(2)
subplot(4,1,1)
plot(data(:,1), data(:,2))
title('unfiltered')
xlabel('Time/s')
ylabel('Magnitude')
axis auto
grid on
subplot(4,1,2)
plot(data(:,1), x22)
title('stdev = 0.1')
xlabel('Time/s')
ylabel('Magnitude')
axis auto
grid on
subplot(4,1,3)
plot(data(:,1), x21)
title('stdev = 0.01')
xlabel('Time/s')
ylabel('Magnitude')
axis auto
grid on
subplot(4,1,4)
plot(data(:,1), x23)
title('stdev = 0.001')
xlabel('Time/s')
ylabel('Magnitude')
axis auto
grid on