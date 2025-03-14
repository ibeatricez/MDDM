% Tradeoff in FRF Measurement - Final Optimized Version
clc; clear; close all;

% Global parameters
fs = 100;            % Sampling frequency (Hz)
RMS_des = 1;         % Desired RMS value
T1 = 6;              % Measurement time in seconds
T2 = 12;             % Extended measurement time

% Ensure integer number of periods
N1 = fs * T1;        % 6 seconds worth of samples
N2 = fs * T2;        % 12 seconds worth of samples

% Select frequencies that fit exactly in FFT bins and within [5,10] Hz
df = fs / N1;  % Frequency resolution
frequencies1 = linspace(5, 10, 30); % 30 frequencies in range [5,10] Hz
frequencies2 = linspace(5, 10, 60); % 60 frequencies in range [5,10] Hz

% Display frequencies to confirm range
disp('Frequencies for 30 lines:');
disp(frequencies1);
disp('Frequencies for 60 lines:');
disp(frequencies2);

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
    plot((0:length(multisines{i})-1)/fs, multisines{i}, 'k'); % Black for better contrast
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(titles{i});
    grid on;

    % Apply Hann window to reduce leakage (only if necessary)
    window = hann(length(multisines{i}))';
    x_windowed = multisines{i} .* window;

    % FFT Calculation
    X = fft(x_windowed);
    X_mag = abs(X(1:N1/2+1));  % Keep only positive half of spectrum
    f = (0:N1/2) * (fs/N1);    % Positive frequency axis

    % Convert to dB scale
    X_dB = 20 * log10(X_mag + 1e-16); 

    % Filter out noise floor for clean plot
    threshold_dB = -120;  % Only show components above -120 dB
    valid_indices = X_dB > threshold_dB;

    % Reduce plotted points for clarity
    plot_step = 5; % Display every 5th frequency bin

    % Plot log-magnitude spectrum with fewer markers
    subplot(6, 2, 2*i);
    stem(f(valid_indices(1:plot_step:end)), X_dB(valid_indices(1:plot_step:end)), ...
         'r', 'filled', 'MarkerSize', 4); % Red markers for better visibility
    xlabel('Frequency (Hz)');
    ylabel('|X(f)| (dB)');
    title([titles{i}, ' - FFT']);
    grid minor;
    ylim([-120, 10]);  % Keeps all FFT plots on the same scale
    xlim([0, 15]);     % Focus only on the relevant frequency range
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
