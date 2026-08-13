clc;
clear;
close all;

%% Original Sequence
n = 0:40;
x = sin(0.3*pi*n);

%% Decimation by 2
y = x(1:2:end);
nd = 0:length(y)-1;

%% Interpolation by 2
v = zeros(1, 2*length(x));
v(1:2:end) = x;
ni = 0:length(v)-1;

%% Figure 1: Original Sequence
figure;
stem(n, x, 'filled');
grid on;
title('Original Sequence x[n]');
xlabel('n');
ylabel('Amplitude');

%% Figure 2: Decimated Sequence
figure;
stem(nd, y, 'filled');
grid on;
title('Decimated Sequence by 2');
xlabel('n');
ylabel('Amplitude');

%% Figure 3: Interpolated Sequence
figure;
stem(ni, v, 'filled');
grid on;
title('Interpolated Sequence by 2');
xlabel('n');
ylabel('Amplitude');

%% Figure 4: Comparison
figure;
stem(n, x, 'b', 'filled');
hold on;

stem(0:2:length(v)-2, v(1:2:end), 'r', 'filled');

legend('Original x[n]', 'Interpolated Samples');
grid on;
title('Comparison of Sequences');
xlabel('n');
ylabel('Amplitude');
