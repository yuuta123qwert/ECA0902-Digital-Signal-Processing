clc;
clear;
close all;

%% Signal Parameters
fs = 1000;
t = (0:999)/fs;

%% Clean Signal
s = sin(2*pi*100*t) + 0.5*sin(2*pi*200*t);

%% Add Gaussian Noise
n = 0.3*randn(size(t));
x = s + n;

%% Fig 1 - Signal with Noise
figure;
plot(t, x);
grid on;
title('Signal with Noise');
xlabel('Time (s)');
ylabel('Amplitude');

%% Fig 2 - PSD using Periodogram
figure;
periodogram(x, [], [], fs);
title('PSD using Periodogram');

%% Fig 3 - Magnitude Spectrum
figure;
X = abs(fft(x));
f = (0:length(X)-1)*fs/length(X);

plot(f(1:500), X(1:500));
grid on;
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Fig 4 - Power Comparison
figure;
bar([mean(s.^2), var(n)]);
set(gca, 'XTickLabel', {'Signal', 'Noise'});
title('Power Comparison');
ylabel('Power');
grid on;
