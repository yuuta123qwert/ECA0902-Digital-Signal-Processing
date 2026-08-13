clc;
clear;
close all;

%% --- Input Parameters ---
fp = 1000;              % High-pass cutoff frequency (Hz)
fs = 8000;              % Sampling frequency (Hz)
N = 50;                 % Filter order
wc = fp/(fs/2);         % Normalized cutoff (0–1)

%% --- FIR High Pass using Hanning Window ---
b_hann = fir1(N, wc, 'high', hanning(N+1));

disp('--- High-Pass Coefficients (Hanning Window) ---');
disp(b_hann');

%% --- Frequency Response Plot ---
figure;
freqz(b_hann, 1);
title('High-Pass FIR using Hanning Window');
