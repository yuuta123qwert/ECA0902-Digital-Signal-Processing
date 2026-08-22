%% POLYPHASE INTERPOLATOR DESIGN AND SIMULATION
% FIR Length = 24 taps
% Interpolation Factor = 4

clc;
clear;
close all;

%% 1. GIVEN PARAMETERS
N = 24;                 % FIR filter length
L = 4;                  % Interpolation factor
Fs = 1000;              % Input sampling frequency (Hz)
Fout = L*Fs;            % Output sampling frequency

%% 2. DESIGN 24-TAP INTERPOLATION FILTER
% Low-pass FIR filter
% Normalized cutoff frequency = 1/L = 0.25

h = fir1(N-1, 1/L, hamming(N));

fprintf('============================================\n');
fprintf('POLYPHASE INTERPOLATOR\n');
fprintf('============================================\n');
fprintf('FIR Length       = %d taps\n', N);
fprintf('Interpolation L  = %d\n', L);
fprintf('Input Fs         = %d Hz\n', Fs);
fprintf('Output Fs        = %d Hz\n\n', Fout);

fprintf('24 FIR Filter Coefficients:\n');
disp(h);

%% 3. POLYPHASE DECOMPOSITION
% Four phases, each containing 6 coefficients

E = zeros(L, N/L);

for k = 1:L
    E(k,:) = h(k:L:end);
end

fprintf('Polyphase Components:\n');
for k = 1:L
    fprintf('E%d = ', k-1);
    fprintf('%+.6f ', E(k,:));
    fprintf('\n');
end

fprintf('\nEach phase contains %d taps.\n\n', N/L);

%% 4. GENERATE TEST INPUT SIGNAL
n = 0:99;

% Input signal containing two frequencies
f1 = 100;       % Hz
f2 = 200;       % Hz

x = sin(2*pi*f1*n/Fs) + ...
    0.5*sin(2*pi*f2*n/Fs);

%% 5. CONVENTIONAL INTERPOLATION
% Insert L-1 = 3 zeros between input samples

x_up = zeros(1, L*length(x));
x_up(1:L:end) = x;

% Filter the zero-inserted signal
y_direct = filter(h, 1, x_up);

%% 6. POLYPHASE INTERPOLATION
% Filter input through each polyphase branch

phase_output = zeros(L, length(x));

for k = 1:L
    phase_output(k,:) = filter(E(k,:), 1, x);
end

% Interleave the phase outputs
y_poly = zeros(1, L*length(x));

for k = 1:L
    y_poly(k:L:end) = phase_output(k,:);
end

%% 7. OUTPUT RECONSTRUCTION VERIFICATION
% Compare direct and polyphase outputs

% Because of the phase convention used in the decomposition,
% find the best alignment between the two outputs.

correlation = xcorr(y_direct, y_poly);
[~, index] = max(abs(correlation));

lag = index - length(y_poly);

if lag > 0
    y_poly_aligned = [zeros(1,lag), y_poly];
    y_poly_aligned = y_poly_aligned(1:length(y_direct));
elseif lag < 0
    shift = abs(lag);
    y_poly_aligned = [y_poly(shift+1:end), ...
                      zeros(1,shift)];
    y_poly_aligned = y_poly_aligned(1:length(y_direct));
else
    y_poly_aligned = y_poly;
end

% Calculate error
minLength = min(length(y_direct), length(y_poly_aligned));

error_signal = y_direct(1:minLength) - ...
               y_poly_aligned(1:minLength);

max_error = max(abs(error_signal));
rms_error = sqrt(mean(error_signal.^2));

fprintf('============================================\n');
fprintf('OUTPUT VERIFICATION\n');
fprintf('============================================\n');
fprintf('Maximum absolute error = %.6e\n', max_error);
fprintf('RMS error              = %.6e\n\n', rms_error);

if max_error < 1e-10
    fprintf('RESULT: Polyphase output matches direct output.\n');
else
    fprintf('RESULT: Check phase alignment.\n');
end

%% 8. COMPUTATIONAL LOAD COMPARISON

% Direct implementation:
% 24 multiplications per output sample
% Output rate = 4*Fs
direct_mult_per_sec = N * L * Fs;

% Polyphase implementation:
% 4 phases x 6 multiplications per input sample
polyphase_mult_per_sec = N * Fs;

% Multiplication saving
saving_percent = ...
    (1 - polyphase_mult_per_sec/direct_mult_per_sec)*100;

efficiency_factor = ...
    direct_mult_per_sec/polyphase_mult_per_sec;

fprintf('\n============================================\n');
fprintf('COMPUTATIONAL LOAD COMPARISON\n');
fprintf('============================================\n');

fprintf('Direct implementation:\n');
fprintf('  Multiplications/input sample = %d\n', N*L);
fprintf('  Multiplications/second       = %d\n', ...
        direct_mult_per_sec);

fprintf('\nPolyphase implementation:\n');
fprintf('  Multiplications/input sample = %d\n', N);
fprintf('  Multiplications/second       = %d\n', ...
        polyphase_mult_per_sec);

fprintf('\nComputational saving = %.2f %%\n', saving_percent);
fprintf('Efficiency improvement = %.2f times\n', efficiency_factor);

%% 9. FILTER FREQUENCY RESPONSE

figure;

freqz(h,1,1024);
title('24-Tap FIR Interpolation Filter');

%% 10. INPUT AND OUTPUT SIGNALS

figure;

subplot(3,1,1);
stem(n, x, 'filled');
grid on;
title('Input Signal');
xlabel('Input Sample');
ylabel('Amplitude');

subplot(3,1,2);
stem(0:length(x_up)-1, x_up, 'filled');
grid on;
title('Zero-Inserted Signal');
xlabel('Output Sample');
ylabel('Amplitude');

subplot(3,1,3);
plot(0:length(y_direct)-1, y_direct, 'b', ...
     'LineWidth', 1.2);
grid on;
title('Interpolated Output');
xlabel('Output Sample');
ylabel('Amplitude');

%% 11. DIRECT VS POLYPHASE OUTPUT

figure;

plot(y_direct, 'b', 'LineWidth', 1.5);
hold on;
plot(y_poly_aligned, '--r', 'LineWidth', 1.2);

grid on;
xlabel('Output Sample');
ylabel('Amplitude');
title('Direct vs Polyphase Interpolator Output');
legend('Direct FIR Interpolation', ...
       'Polyphase Interpolation');

%% 12. RECONSTRUCTION ERROR

figure;

plot(error_signal, 'k', 'LineWidth', 1.2);
grid on;
xlabel('Output Sample');
ylabel('Error');
title('Reconstruction Error');

%% 13. SPECTRUM COMPARISON

figure;

subplot(2,1,1);
pwelch(x, [], [], [], Fs);
title('Input Signal Spectrum');

subplot(2,1,2);
pwelch(y_direct, [], [], [], Fout);
title('Interpolated Output Spectrum');

%% 14. FINAL SUMMARY

fprintf('\n============================================\n');
fprintf('FINAL SUMMARY\n');
fprintf('============================================\n');
fprintf('FIR filter length       : %d taps\n', N);
fprintf('Interpolation factor    : %d\n', L);
fprintf('Polyphase branches      : %d\n', L);
fprintf('Taps per branch         : %d\n', N/L);
fprintf('Input sampling rate     : %d Hz\n', Fs);
fprintf('Output sampling rate    : %d Hz\n', Fout);
fprintf('Direct multiplications  : %d / sec\n', ...
        direct_mult_per_sec);
fprintf('Polyphase multiplications: %d / sec\n', ...
        polyphase_mult_per_sec);
fprintf('Computational saving    : %.2f %%\n', saving_percent);
fprintf('Efficiency improvement  : %.2fx\n', efficiency_factor);
fprintf('Maximum reconstruction error: %.6e\n', max_error);

fprintf('\nConclusion:\n');
fprintf(['Polyphase interpolation eliminates unnecessary ', ...
         'operations on inserted zero samples. ']);
fprintf(['For L = 4 and a 24-tap FIR filter, the ', ...
         'computational load is reduced by 75%%.\n']);
