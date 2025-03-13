clear; clc; close all;

%% Load Measured Data
load('MeasuredData.mat'); % Ensure measured data is saved in this file

% Ensure signals are column vectors
u = u(:); % Input signal
y = y(:); % Output signal

%% Define Parameters
fs = 8000;   % Sampling frequency (Hz)
N = length(u); % Number of samples
T = N / fs;  % Measurement time (s)
f_res = 1 / T; % Current frequency resolution (Hz)
freqs = (0:N/2-1) * (fs / N); % Frequency axis (positive part)

%% Compute Fourier Transforms
U = fft(u) / N;
Y = fft(y) / N;

%% Plot Spectra of Input and Output Signals
figure;
subplot(2,1,1);
plot(freqs, abs(U(1:N/2)));
title('Input Spectrum');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
grid on;

subplot(2,1,2);
plot(freqs, abs(Y(1:N/2)));
title('Output Spectrum');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
grid on;

%% Identify the Important Frequency Band
threshold = 0.01 * max(abs(Y)); % Define threshold for significant frequencies
important_indices = find(abs(Y(1:N/2)) > threshold);
important_frequencies = freqs(important_indices);

disp('Important Frequency Range:');
disp([min(important_frequencies), max(important_frequencies)]);

%% Adjust Frequency Resolution
% To improve resolution, we increase measurement time (i.e., more samples)
desired_f_res = 0.1; % Target frequency resolution (Hz)
desired_T = 1 / desired_f_res; % Required measurement time (s)
desired_N = round(desired_T * fs); % Required number of samples

disp(['Current Frequency Resolution: ', num2str(f_res), ' Hz']);
disp(['Desired Frequency Resolution: ', num2str(desired_f_res), ' Hz']);
disp(['Required Number of Samples: ', num2str(desired_N)]);

