clear; clc; close all;

%% Define Parameters
fs = 8000;     % Sampling frequency in Hz
N = fs;        % Number of time samples (1-second duration)
f_min = 1;     % Minimum frequency (Hz)
f_max = 500;   % Maximum frequency (Hz)
f_res = 1;     % Frequency resolution (Hz)
K = (f_max - f_min) / f_res + 1; % Number of excited frequencies
t = (0:N-1) / fs; % Time vector (1 second)

%% Generate Frequency Bins
f_k = linspace(f_min, f_max, K); % Excited frequencies
k = round(f_k / f_res); % Frequency indices in bins (rounded to nearest integer)

%% Generate Schroeder Phase
schroeder_phase = (k .* (k + 1) * pi) / K; % Schroeder phase formula

%% Generate Multisine Signal in Frequency Domain
X = zeros(N, 1);  % Initialize spectrum
X(k+1) = (1 / sqrt(K)) * exp(1j * schroeder_phase'); % Assign frequencies

% Ensure Conjugate Symmetry for Real Signal
X(N-k+1) = conj(X(k+1)); 

%% Inverse FFT to Obtain Time-Domain Signal
x = real(ifft(X) * N);

%% Scale RMS to 100 mV
RMS_desired = 0.1; % 100 mV
x = x * (RMS_desired / rms(x)); % Normalize RMS value

%% Plot Time-Domain Signal
figure;
plot(t, x);
title('Schroeder Multisine - Time Domain');
xlabel('Time (s)');
ylabel('Amplitude (V)');
grid on;

%% Compute and Plot Frequency Spectrum
X_mag = abs(fft(x)) / N;  % Normalize properly
freqs = (0:N/2-1) * (fs / N); % Frequency axis (only positive frequencies)

figure;
plot(freqs, X_mag(1:N/2));
valid_range = (f_k >= f_min) & (f_k <= f_max);
plot(f_k(valid_range), X_mag(k(valid_range)));

title('Schroeder Multisine - Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

%% Display Excited Frequencies for Verification
disp('Excited Frequencies (Hz):');
disp(f_k(1:10)); % Check first 10 excited frequencies
disp(f_k(end-10:end)); % Check last 10 excited frequencies

%% Save Signal (if needed for LabVIEW)
save('SchroederMultisine.mat', 'x', 'fs');
