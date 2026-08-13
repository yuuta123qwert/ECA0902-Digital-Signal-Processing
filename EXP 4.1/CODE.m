clc;
clear;
close all;

%% --- Input Parameters ---
fp = 1000;              % Passband cutoff frequency (Hz)
fs = 4000;              % Sampling frequency (Hz)
N = 50;                 % FIR filter order

% Normalized cutoff frequency
wc = fp / (fs/2);

%% --- 1. FIR Low-Pass using Rectangular Window ---
b_rect = fir1(N, wc, 'low', rectwin(N+1));

disp('--- Rectangular Window Coefficients ---');
disp(b_rect');

%% --- 2. FIR Low-Pass using Hamming Window ---
b_hamm = fir1(N, wc, 'low', hamming(N+1));

disp('--- Hamming Window Coefficients ---');
disp(b_hamm');

%% --- 3. FIR Low-Pass using Hanning Window ---
b_hann = fir1(N, wc, 'low', hanning(N+1));

disp('--- Hanning Window Coefficients ---');
disp(b_hann');

%% --- Plot Frequency Responses ---

figure;
freqz(b_rect, 1);
title('FIR Low-Pass Filter using Rectangular Window');

figure;
freqz(b_hamm, 1);
title('FIR Low-Pass Filter using Hamming Window');

figure;
freqz(b_hann, 1);
title('FIR Low-Pass Filter using Hanning Window');
