clc;
clear;
close all;

%% Parameters
Fs = 8000;
t = 0:1/Fs:3;

%% Clean Signal
x = sin(2*pi*200*t) + 0.5*sin(2*pi*400*t);

%% Add Noise
noise = 0.3 * randn(size(x));
xn = x + noise;

%% FFT
Y = fft(xn);
N = fft(noise);

%% Spectral Subtraction
magY = abs(Y);
phaseY = angle(Y);

magE = max(magY - abs(N), 0);

xe = real(ifft(magE .* exp(1j*phaseY)));

%% Time-Domain Signals
figure;

subplot(3,1,1);
plot(t,x);
title('Clean Speech');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t,xn);
title('Noisy Speech');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t,xe);
title('Enhanced Speech');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% Spectrograms
figure;

subplot(3,1,1);
spectrogram(x,256,128,256,Fs,'yaxis');
title('Clean Spectrogram');

subplot(3,1,2);
spectrogram(xn,256,128,256,Fs,'yaxis');
title('Noisy Spectrogram');

subplot(3,1,3);
spectrogram(xe,256,128,256,Fs,'yaxis');
title('Enhanced Spectrogram');

%% Magnitude Spectra
figure;

Nfft = length(x);

subplot(3,1,1);
plot((0:Nfft-1)*Fs/Nfft,abs(fft(x)));
title('Clean Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);
grid on;

subplot(3,1,2);
plot((0:Nfft-1)*Fs/Nfft,abs(fft(xn)));
title('Noisy Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);
grid on;

subplot(3,1,3);
plot((0:Nfft-1)*Fs/Nfft,abs(fft(xe)));
title('Enhanced Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);
grid on;
