clc;
clear;
close all;

% Specifications
Fs = 2000;       % Sampling Frequency (Hz)
Rp = 1;          % Passband Ripple (dB)
Rs = 40;         % Stopband Attenuation (dB)

% Passband and Stopband Frequencies
Wp = [300 600] / (Fs/2);
Ws = [200 700] / (Fs/2);

%% Butterworth Band-Pass Filter
[n1, W1] = buttord(Wp, Ws, Rp, Rs);
[b1, a1] = butter(n1, W1, 'bandpass');

%% Chebyshev Type-I Band-Pass Filter
[n2, W2] = cheb1ord(Wp, Ws, Rp, Rs);
[b2, a2] = cheby1(n2, Rp, W2, 'bandpass');

%% Magnitude and Phase Response

figure;
freqz(b1, a1);
title('Butterworth Band-Pass Filter');

figure;
freqz(b2, a2);
title('Chebyshev Type-I Band-Pass Filter');

%% Group Delay

figure;
grpdelay(b1, a1);
hold on;
grpdelay(b2, a2);
legend('Butterworth', 'Chebyshev-I');
title('Group Delay Comparison');
grid on;

%% Pole-Zero Plot

figure;

subplot(1,2,1);
zplane(b1, a1);
title('Butterworth Pole-Zero');

subplot(1,2,2);
zplane(b2, a2);
title('Chebyshev-I Pole-Zero');

%% Impulse Response

figure;

subplot(2,1,1);
impz(b1, a1);
title('Butterworth Impulse Response');
grid on;

subplot(2,1,2);
impz(b2, a2);
title('Chebyshev-I Impulse Response');
grid on;

%% Pole Magnitude

figure;

subplot(1,2,1);
stem(abs(roots(a1)), 'filled');
title('Butterworth Pole Magnitude');
xlabel('Pole Number');
ylabel('Magnitude');
grid on;

subplot(1,2,2);
stem(abs(roots(a2)), 'filled');
title('Chebyshev-I Pole Magnitude');
xlabel('Pole Number');
ylabel('Magnitude');
grid on;

%% Display Filter Orders

fprintf('Butterworth Filter Order = %d\n', n1);
fprintf('Chebyshev Type-I Filter Order = %d\n', n2);
