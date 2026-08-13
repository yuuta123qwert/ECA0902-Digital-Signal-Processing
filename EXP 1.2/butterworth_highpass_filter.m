clc;
clear;
close all;

% Filter Specifications
Fs = 10000;       % Sampling Frequency (Hz)
Fp = 3000;        % Passband Frequency (Hz)
Fst = 2000;       % Stopband Frequency (Hz)
Rp = 1;           % Passband Ripple (dB)
Rs = 60;          % Stopband Attenuation (dB)

% Normalize frequencies
Wp = Fp/(Fs/2);
Ws = Fst/(Fs/2);

% Calculate minimum filter order and cutoff frequency
[N, Wn] = buttord(Wp, Ws, Rp, Rs);

% Design Butterworth High-Pass Filter
[b, a] = butter(N, Wn, 'high');

% Magnitude and Phase Response
figure;
freqz(b, a);
title('Butterworth High-Pass Filter - Magnitude and Phase');

% Impulse Response
figure;
[h, n] = impz(b, a, 50);
stem(n, h);
grid on;
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');

% Step Response
figure;
stepz(b, a);
grid on;
title('Step Response');

% Group Delay
figure;
grpdelay(b, a);
title('Group Delay');

% Pole-Zero Plot
figure;
zplane(b, a);
grid on;
title('Pole-Zero Plot');

% Display Results
fprintf('Minimum Filter Order (N) = %d\n', N);
fprintf('Cutoff Frequency (Wn) = %.4f\n', Wn);
