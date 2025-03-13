clear; clc; close all;

%% Load Measured Input and Output Signals
load('MeasuredData.mat'); % Assumes measured signals are saved

% Ensure signals are column vectors
u = u(:); % Input signal
y = y(:); % Output signal

%% Define Parameters
fs = 8000;   % Sampling frequency
N = length(u); % Number of samples
num_periods = 5; % Number of periods to analyze
samples_per_period = N / num_periods; % Samples in each period

%% Plot Measured Input and Output Signals for Each Period
figure;
for i = 1:num_periods
    subplot(num_periods, 1, i);
    plot((0:samples_per_period-1)/fs, u((i-1)*samples_per_period+1:i*samples_per_period));
    title(['Input Signal - Period ', num2str(i)]);
    xlabel('Time (s)'); ylabel('Amplitude');
end

figure;
for i = 1:num_periods
    subplot(num_periods, 1, i);
    plot((0:samples_per_period-1)/fs, y((i-1)*samples_per_period+1:i*samples_per_period));
    title(['Output Signal - Period ', num2str(i)]);
    xlabel('Time (s)'); ylabel('Amplitude');
end

%% Compute FRF for Each Period Separately
H = zeros(samples_per_period, num_periods); % Initialize FRF matrix
freqs = (0:samples_per_period-1) * (fs / samples_per_period); % Frequency axis

figure;
for i = 1:num_periods
    % Extract single period of input and output
    u_period = u((i-1)*samples_per_period+1:i*samples_per_period);
    y_period = y((i-1)*samples_per_period+1:i*samples_per_period);
    
    % Compute Fourier transforms
    U = fft(u_period);
    Y = fft(y_period);
    
    % Compute FRF
    H(:, i) = Y ./ U; % Frequency Response Function
    
    % Plot FRF Magnitude
    subplot(num_periods, 1, i);
    plot(freqs, abs(H(:, i)));
    title(['FRF - Period ', num2str(i)]);
    xlabel('Frequency (Hz)'); ylabel('Magnitude');
end

%% Decision on Periods
% Analyze differences between FRFs
mean_FRF = mean(abs(H), 2);
std_FRF = std(abs(H), 0, 2);

% Plot mean FRF and standard deviation
figure;
subplot(2,1,1);
plot(freqs, mean_FRF);
title('Mean FRF');
xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(2,1,2);
plot(freqs, std_FRF);
title('FRF Standard Deviation');
xlabel('Frequency (Hz)'); ylabel('Std Dev');

%% Identify and Remove Bad Periods
threshold = 0.05; % Set threshold for acceptable variation
bad_periods = find(std_FRF > threshold);
disp('Periods with high variation:');
disp(bad_periods);

