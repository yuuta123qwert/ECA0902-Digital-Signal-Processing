clc;
clear;
close all;

%% --- Input Parameters ---
fp = 1000;              % Passband cutoff frequency (Hz)
fs = 4000;              % Sampling frequency (Hz)
N = 50;                 % Filter order (even number preferred)

% Normalized cutoff frequency
wc = fp/(fs/2);

%% --- FIR Low-Pass using Hamming Window ---
b_hamm = fir1(N, wc, 'low', hamming(N+1));

% Display Filter Coefficients
disp('--- Hamming Window Coefficients ---');
disp(b_hamm');

%% --- Plot Frequency Response ---
figure;
freqz(b_hamm, 1);
grid on;
title('FIR Low-Pass Filter using Hamming Window');

%% --- Impulse Response ---
figure;
impz(b_hamm, 1);
grid on;
title('Impulse Response - Hamming Window');

%% --- Group Delay ---
figure;
grpdelay(b_hamm, 1);
grid on;
title('Group Delay - Hamming Window');
