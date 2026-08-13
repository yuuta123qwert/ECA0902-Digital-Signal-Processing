clc;
clear;
close all;

% Filter Specifications
Wp = 0.4;       % Passband edge frequency (normalized)
Ws = 0.55;      % Stopband edge frequency (normalized)
Rp = 1;         % Passband ripple (dB)
As = 40;        % Stopband attenuation (dB)

% Calculate minimum filter order
[N, Wn] = cheb1ord(Wp, Ws, Rp, As);

% Design Chebyshev Type-I Low-Pass Filter
[b, a] = cheby1(N, Rp, Wn, 'low');

% Display Filter Specifications
fprintf('Filter Order = %d\n', N);
fprintf('Cutoff Frequency = %.4f * pi rad/sample\n', Wn);

% Stability Check
if all(abs(roots(a)) < 1)
    disp('System is STABLE');
else
    disp('System is UNSTABLE');
end

% -------- GRAPHS --------

% Magnitude and Phase Response
figure;
freqz(b, a);
title('Chebyshev Type-I Low-Pass Filter');

% Impulse Response
figure;
impz(b, a);
grid on;
title('Impulse Response');

% Group Delay
figure;
grpdelay(b, a);
title('Group Delay');

% Pole-Zero Plot
figure;
zplane(b, a);
grid on;
title('Pole-Zero Plot');
