clc;
clear;
close all;

%% --- Input Parameters ---
fp = 1000;              % Passband cutoff frequency (Hz)
fs = 4000;              % Sampling frequency (Hz)
N = 50;                 % Filter order (even number preferred)

% Normalized cutoff frequency
wc = fp/(fs/2);

%% --- FIR Low-Pass using Hanning Window ---
b_hann = fir1(N, wc, 'low', hanning(N+1));

% Display Filter Coefficients
disp('--- Hanning Window Coefficients ---');
disp(b_hann');

%% --- Plot Frequency Response ---
figure;
freqz(b_hann, 1);
grid on;
title('FIR Low-Pass Filter using Hanning Window');

%% --- Impulse Response ---
figure;
impz(b_hann, 1);
grid on;
title('Impulse Response - Hanning Window');

%% --- Group Delay ---
figure;
grpdelay(b_hann, 1);
grid on;
title('Group Delay - Hanning Window');
