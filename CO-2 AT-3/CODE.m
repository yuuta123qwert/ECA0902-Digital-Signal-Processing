%% SQNR ERROR ANALYSIS
% Question:
% An engineer claims that increasing word length from
% 8 bits to 10 bits improves SQNR by 3 dB.
% Analyze the statement and calculate the correct improvement.

clc;
clear;
close all;

%% Given Word Lengths
N1 = 8;       % Original word length
N2 = 10;      % New word length

%% Calculate SQNR
% Ideal quantizer equation:
% SQNR = 6.02*N + 1.76 dB

SQNR_8  = 6.02*N1 + 1.76;
SQNR_10 = 6.02*N2 + 1.76;

%% Calculate Correct Improvement
SQNR_improvement = SQNR_10 - SQNR_8;

%% Engineer's Claim
engineer_claim = 3;     % dB

%% Error in Engineer's Claim
error = SQNR_improvement - engineer_claim;

%% Display Results
fprintf('============================================\n');
fprintf('       SQNR ERROR ANALYSIS\n');
fprintf('============================================\n');

fprintf('Original word length = %d bits\n', N1);
fprintf('New word length      = %d bits\n\n', N2);

fprintf('SQNR at 8 bits  = %.2f dB\n', SQNR_8);
fprintf('SQNR at 10 bits = %.2f dB\n\n', SQNR_10);

fprintf('Engineer claim       = %.2f dB\n', engineer_claim);
fprintf('Correct improvement  = %.2f dB\n', SQNR_improvement);
fprintf('Claim error           = %.2f dB\n\n', error);

%% Explanation
fprintf('============================================\n');
fprintf('ERROR ANALYSIS\n');
fprintf('============================================\n');

fprintf(['Each additional bit improves ideal SQNR by ', ...
         'approximately 6.02 dB.\n']);

fprintf('Number of additional bits = %d bits\n', N2-N1);

fprintf('Therefore:\n');
fprintf('SQNR improvement = 2 x 6.02 = %.2f dB\n\n', ...
        2*6.02);

if abs(SQNR_improvement - engineer_claim) > 0.01
    fprintf('The engineer''s claim of 3 dB is INCORRECT.\n');
    fprintf('The correct improvement is approximately %.2f dB.\n', ...
            SQNR_improvement);
else
    fprintf('The engineer''s claim is correct.\n');
end

%% Comparison Plot
word_lengths = [N1 N2];
sqnr_values = [SQNR_8 SQNR_10];

figure;
bar(word_lengths, sqnr_values);

grid on;
xlabel('Word Length (bits)');
ylabel('SQNR (dB)');
title('SQNR Improvement: 8-bit vs 10-bit');

% Display values on bars
for i = 1:length(word_lengths)
    text(word_lengths(i), sqnr_values(i), ...
        sprintf(' %.2f dB', sqnr_values(i)), ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','bottom');
end

%% Final Result
fprintf('\n============================================\n');
fprintf('FINAL RESULT\n');
fprintf('============================================\n');
fprintf('8-bit SQNR  = %.2f dB\n', SQNR_8);
fprintf('10-bit SQNR = %.2f dB\n', SQNR_10);
fprintf('Improvement = %.2f dB\n', SQNR_improvement);
fprintf('Claimed     = %.2f dB\n', engineer_claim);

fprintf('\nConclusion: Increasing word length from 8 to 10 bits\n');
fprintf('improves ideal SQNR by approximately 12.04 dB, not 3 dB.\n');
