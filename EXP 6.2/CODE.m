clc;
clear;
close all;

n = 0:79;
x = sin(2*pi*n/40);
q = 8;

%% Quantization
xt = floor(x*q)/q;      % Truncation
xr = round(x*q)/q;      % Rounding

%% Quantization Error
et = x - xt;            % Truncation error
er = x - xr;            % Rounding error

%% Fig 1 - Original vs Quantized
figure;
plot(n, x, 'b', n, xr, 'r', 'LineWidth', 1.5);
grid on;
title('Original vs Quantized');
legend('Original', 'Quantized');

%% Fig 2 - Truncation vs Rounding
figure;
plot(n, x, 'b', n, xt, 'r', n, xr, 'g', 'LineWidth', 1.5);
grid on;
title('Truncation vs Rounding');
legend('Original', 'Truncated', 'Rounded');

%% Fig 3 - Quantization Error
figure;
stem(n, et, 'r');
hold on;
stem(n, er, 'g');
grid on;
title('Quantization Error');
legend('Truncation', 'Rounding');

%% Fig 4 - MSE Comparison
figure;
bar([mean(et.^2), mean(er.^2)]);
set(gca, 'XTickLabel', {'Truncation', 'Rounding'});
grid on;
title('MSE Comparison');
ylabel('MSE');
