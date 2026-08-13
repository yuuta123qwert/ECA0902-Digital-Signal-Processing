clc;
clear;
close all;

%% Signal
fs = 1000;
f = 50;
t = 0:1/fs:0.1;
x = sin(2*pi*f*t);

%% Quantization Levels
L = [8 16 32];
colors = {'r','g','m'};

figure;

for i = 1:length(L)

    % Quantization
    xq{i} = round((x + 1) .* (L(i) - 1) / 2) ...
            .* (2 / (L(i) - 1)) - 1;

    % Error & MSE
    e{i} = x - xq{i};
    mse(i) = mean(e{i}.^2);

    % Plot Quantized Signals
    subplot(4,1,i+1);
    stairs(t, xq{i}, colors{i}, 'LineWidth', 1.2);
    title(['Quantized Signal (' num2str(L(i)) ' Levels)']);
    grid on;

end

%% Original Signal
subplot(4,1,1);
plot(t, x, 'LineWidth', 1.5);
title('Original Signal');
grid on;

%% Display MSE
fprintf('MSE for 8 Levels  = %f\n', mse(1));
fprintf('MSE for 16 Levels = %f\n', mse(2));
fprintf('MSE for 32 Levels = %f\n', mse(3));

%% Error Plots
figure;

for i = 1:3
    subplot(3,1,i);
    plot(t, e{i});
    title(['Error (' num2str(L(i)) ' Levels)']);
    grid on;
end
