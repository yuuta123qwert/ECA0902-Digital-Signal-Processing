clc;
clear;
close all;

% Specifications
Rp = 1;          % Passband Ripple (dB)
Rs = 40;         % Stopband Attenuation (dB)
Wp = 0.5;        % Passband Edge (normalized)
Ws = 0.35;       % Stopband Edge (normalized)

% Find Filter Order
[n, Wn] = cheb1ord(Wp, Ws, Rp, Rs);

% Design High-Pass Filter
[b, a] = cheby1(n, Rp, Wn, 'high');

% Frequency Response
figure;
freqz(b, a);
title('Frequency Response');

% Impulse Response
figure;
impz(b, a);
grid on;
title('Impulse Response');

% Group Delay
figure;
grpdelay(b, a);
grid on;
title('Group Delay');

% Pole-Zero Plot
figure;
zplane(b, a);
grid on;
title('Pole-Zero Plot');

% Display Results
fprintf('Filter Order = %d\n', n);
fprintf('Cutoff Frequency = %.4f\n', Wn);
