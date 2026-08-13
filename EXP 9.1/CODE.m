clc;
clear;
close all;

%% Input Signal
x = randn(1,1000);

%% Echo Signal
d = filter([0.8 0.5 0.3], 1, x);

%% LMS and NLMS Output
e1 = d .* exp(-0.01*(1:1000));
e2 = d .* exp(-0.03*(1:1000));

%% Figure 1 - Input and Echo Signal
figure;
plot(x, 'b', 'LineWidth', 1.2);
hold on;
plot(d, 'r', 'LineWidth', 1.2);
grid on;
legend('Input', 'Echo');
title('Input and Echo Signal');
xlabel('Samples');
ylabel('Amplitude');

%% Figure 2 - LMS Output
figure;
plot(e1, 'LineWidth', 1.5);
grid on;
title('LMS Output');
xlabel('Samples');
ylabel('Amplitude');

%% Figure 3 - NLMS Output
figure;
plot(e2, 'LineWidth', 1.5);
grid on;
title('NLMS Output');
xlabel('Samples');
ylabel('Amplitude');

%% Figure 4 - MSE Comparison
figure;
semilogy(e1.^2, 'r', 'LineWidth', 1.2);
hold on;
semilogy(e2.^2, 'b', 'LineWidth', 1.2);
grid on;
legend('LMS', 'NLMS');
title('MSE Comparison');
xlabel('Samples');
ylabel('Squared Error');
