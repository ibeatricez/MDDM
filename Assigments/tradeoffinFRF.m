% Tradeoff in FRF Measurement - Fixed Leakage
clc; clear; close all;

% Global parameters
fs = 100;            % Sampling frequency (Hz)
RMS_des = 1;         % Desired RMS value
T1 = 6;              % Measurement time in seconds
T2 = 12;             % Extended measurement time

% Ensure integer number of periods
N1 = fs * T1;        % 6 seconds worth of samples
N2 = fs * T2;        % 12 seconds worth of samples

% Select frequencies that fit exactly in window
k1 = 1:30;  
frequencies1 = k1 / T1;  % Frequencies matching integer cycles
k2 = 1:60;
frequencies2 = k2 / T1;  % Higher resolution, same time

% Generate multisines
x1 = generate_multisine(N1, frequencies1, fs, RMS_des);
x2 = generate_multisine(N2, frequencies1, fs, RMS_des);
x3 = x1;  % Fixed Time, same as x1
x4 = generate_multisine(N1, frequencies2, fs, RMS_des);
x5 = x1;  % Fixed SNR, same as x1
x6 = generate_multisine(N2, frequencies2, fs, RMS_des);

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

    % Apply Hann window to reduce leakage
    window = hann(length(multisines{i}))';
    x_windowed = multisines{i} .* window;

    % FFT Calculation
    X = fftshift(x_windowed);
    f = (0:length(X)-1) * (fs/length(X));

    % Convert to dB scale
    X_dB = 20 * log10(abs(X) + 1e-16); 

    % Plot log-magnitude spectrum
    subplot(6, 2, 2*i);
    stem(f, X_dB, 'b', 'filled');
    xlabel('Frequency (Hz)');
    ylabel('|X(f)| (dB)');
    title([titles{i}, ' - FFT']);
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
