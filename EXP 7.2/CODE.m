clc;
clear;
close all;

%% Signal
fs = 1000;
N = 256;
t = (0:N-1)/fs;

x = sin(2*pi*100*t) + 0.8*sin(2*pi*110*t);

%% FFT Parameters
NFFT = 2048;
f = (0:NFFT/2-1)*(fs/NFFT);

%% Windows
w = {rectwin(N), hamming(N), hann(N)};
names = {'Rectangular', 'Hamming', 'Hanning'};

%% Processing
P = cell(1,3);

for i = 1:3

    xw = x(:) .* w{i};

    X = fft(xw, NFFT);

    P{i} = abs(X(1:NFFT/2));

    % Normalize
    P{i} = P{i}/max(P{i});

end

%% Individual Spectrums
figure;

for i = 1:3

    subplot(3,1,i);

    plot(f, 20*log10(P{i} + eps), 'LineWidth', 1.5);

    title(['Spectrum using ' names{i} ' Window']);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');

    xlim([0 250]);
    grid on;

end

%% Comparison
figure;

plot(f, 20*log10(P{1} + eps), 'k', ...
     f, 20*log10(P{2} + eps), 'r', ...
     f, 20*log10(P{3} + eps), 'b', ...
     'LineWidth', 1.5);

legend(names);
title('Window Comparison');

xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

xlim([50 170]);
grid on;

%% Window Shapes
figure;

for i = 1:3

    subplot(3,1,i);

    plot(w{i}, 'LineWidth', 1.5);

    title([names{i} ' Window']);
    xlabel('Sample');
    ylabel('Amplitude');

    grid on;

end

%% Peak Detection
for i = 1:3

    [pks{i}, loc{i}] = findpeaks(P{i}, f, ...
        'MinPeakHeight', 0.3);

    fprintf('\n%s Window Frequencies:\n', names{i});

    disp(loc{i});

end

%% Peak Marking - Hamming
figure;

plot(f, 20*log10(P{2} + eps), 'LineWidth', 1.5);
hold on;

plot(loc{2}, 20*log10(pks{2} + eps), ...
    'ro', 'MarkerFaceColor', 'r');

title('Detected Frequencies (Hamming)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

xlim([50 170]);
grid on;

%% Main Peaks
fprintf('\nMain Spectral Peaks:\n');

for i = 1:3

    [~, idx] = max(P{i});

    fprintf('%s Window Peak = %.2f Hz\n', ...
        names{i}, f(idx));

end
