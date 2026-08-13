clc;
clear;
close all;

%% --- Input Parameters ---
fp = 1000;              % High-pass cutoff frequency (Hz)
fs = 8000;              % Sampling frequency (Hz)
N = 50;                 % Filter order
wc = fp/(fs/2);         % Normalized cutoff (0–1)

%% --- FIR High Pass using Hamming Window ---
b_hamm = fir1(N, wc, 'high', hamming(N+1));

disp('--- High-Pass Coefficients (Hamming Window) ---');
disp(b_hamm');

%% --- Frequency Response Plot ---
figure;
freqz(b_hamm, 1);
title('High-Pass FIR using Hamming Window');
