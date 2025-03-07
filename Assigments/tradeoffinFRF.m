% Tradeoff in FRF Measurement
% Objective: Illustrate trade-offs between frequency resolution, measurement time, and SNR
clc; clear; close all;

% Global parameters
fs = 100;            % Sampling frequency (Hz)
RMS_des = 1;         % Desired RMS value
f_start = 5;         % Start frequency (Hz)
f_end = 10;          % End frequency (Hz)

% --- Tradeoff 1: Fixed Frequency Resolution ---
% Multisine 1 - 30 lines, 6 seconds
N1 = fs * 6;                          % 6 seconds worth of samples
frequencies1 = linspace(f_start, f_end, 30);
x1 = generate_multisine(N1, frequencies1, fs, RMS_des);

% Multisine 2 - 30 lines, 12 seconds (better SNR)
N2 = fs * 12;                         % 12 seconds worth of samples
x2 = generate_multisine(N2, frequencies1, fs, RMS_des);

% --- Tradeoff 2: Fixed Measurement Time ---
% Multisine 3 - 30 lines, 6 seconds
x3 = x1;  % Same as Multisine 1 (fixed time = same N)

% Multisine 4 - 60 lines, 6 seconds (worse SNR, finer resolution)
frequencies4 = linspace(f_start, f_end, 60);
x4 = generate_multisine(N1, frequencies4, fs, RMS_des);

% --- Tradeoff 3: Fixed SNR ---
% Multisine 5 - 30 lines, 6 seconds, fixed SNR
x5 = x1;  % Same as Multisine 1 (same power spread over 30 lines)

% Multisine 6 - 60 lines, 12 seconds (more frequencies, but maintain SNR by longer time)
x6 = generate_multisine(N2, frequencies4, fs, RMS_des);

% ---- Plot all results ----
multisines = {x1, x2, x3, x4, x5, x6};
titles = {
    'Fixed Resolution - 30 lines, 6s', ...
    'Fixed Resolution - 30 lines, 12s (Better SNR)', ...
    'Fixed Time - 30 lines, 6s', ...
    'Fixed Time - 60 lines, 6s (Finer Resolution, Worse SNR)', ...
    'Fixed SNR - 30 lines, 6s', ...
    'Fixed SNR - 60 lines, 12s (More Lines, Longer Time)'
};

figure;
for i = 1:6
    subplot(6, 2, 2*i-1);
    plot((0:length(multisines{i})-1)/fs, multisines{i});
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(titles{i});

    subplot(6, 2, 2*i);
    X = fft(multisines{i});
    f = (0:length(X)-1) * (fs/length(X));
    stem(f, abs(X), 'b', 'filled');
    xlabel('Frequency (Hz)');
    ylabel('|X(f)|');
end

disp('All multisines generated and plotted successfully.');

% ===== Helper Function =====
function x = generate_multisine(N, frequencies, fs, RMS_des)
    t = (0:N-1) / fs;  % Time vector
    x = zeros(1, N);   % Initialize signal

    for f = frequencies
        phase = 2 * pi * rand();  % Random phase for each frequency
        x = x + cos(2*pi*f*t + phase);
    end

    % Scale to desired RMS
    RMS_x = sqrt(mean(x.^2));
    x = x * (RMS_des / RMS_x);
end
