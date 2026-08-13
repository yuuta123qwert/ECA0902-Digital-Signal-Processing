clc;
clear;
close all;

%% --- Input Parameters ---
fp = 1000;              % High-pass cutoff frequency (Hz)
fs = 8000;              % Sampling frequency (Hz)
N = 50;                 % Filter order

wc = fp/(fs/2);         % Normalized cutoff frequency (0–1)

%% --- 1. FIR High-Pass using Rectangular Window ---
b_rect = fir1(N, wc, 'high', rectwin(N+1));

disp('--- High-Pass Coefficients (Rectangular Window) ---');
disp(b_rect');

%% --- 2. FIR High-Pass using Hamming Window ---
b_hamm = fir1(N, wc, 'high', hamming(N+1));

disp('--- High-Pass Coefficients (Hamming Window) ---');
disp(b_hamm');

%% --- 3. FIR High-Pass using Hanning Window ---
b_hann = fir1(N, wc, 'high', hanning(N+1));

disp('--- High-Pass Coefficients (Hanning Window) ---');
disp(b_hann');

%% --- Frequency Response Plots ---

figure;
freqz(b_rect, 1);
title('High-Pass FIR using Rectangular Window');

figure;
freqz(b_hamm, 1);
title('High-Pass FIR using Hamming Window');

figure;
freqz(b_hann, 1);
title('High-Pass FIR using Hanning Window');
