clc;
clear;
close all;

% Filter Specifications
Fsamp = 8000;     % Sampling Frequency (Hz)
Fp = 1000;        % Passband Frequency (Hz)
Fst = 3000;       % Stopband Frequency (Hz)
Rp = 1;           % Passband Ripple (dB)
Rs = 20;          % Stopband Attenuation (dB)

% Normalize frequencies with respect to Nyquist frequency
Wp = Fp/(Fsamp/2);
Ws = Fst/(Fsamp/2);

% Find minimum Butterworth filter order
[N, Wn] = buttord(Wp, Ws, Rp, Rs);

% Design Butterworth Low-Pass Filter
[b, a] = butter(N, Wn, 'low');

% Display filter order and cutoff frequency
fprintf('Minimum Filter Order (N) = %d\n', N);
fprintf('Normalized Cutoff Frequency (Wn) = %.4f\n', Wn);

% Frequency Response
figure;
freqz(b, a, 1024, Fsamp);
title('Butterworth Low-Pass Filter - Magnitude and Phase Response');

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

% Pole-Zero Plot
figure;
zplane(b, a);
grid on;
title('Pole-Zero Plot');
