% Lab 2, Question 5: Generating Multisine Signals

clear; clc; close all;

% Define parameters
N = 4096; % Number of time samples
K = 100;  % Number of excited spectral lines
fs = 8000; % Sampling frequency in Hz
t = (0:N-1) / fs; % Time vector
f0 = fs / N; % Fundamental frequency

% Generate frequency indices for the first 100 bins
k = 1:K;

% Define amplitude (constant for all frequencies)
Ak = ones(1, K); % Constant amplitude

% Generate different phase spectra
constant_phase = zeros(1, K); % Constant phase spectrum
random_phase = 2 * pi * rand(1, K); % Random phase spectrum
schroeder_phase = (k .* (k + 1) * pi) / K; % Schroeder phase spectrum

% Generate multisine signals
x_constant = sum(Ak .* cos(2 * pi * k' * f0 * t + constant_phase'), 1);
x_random = sum(Ak .* cos(2 * pi * k' * f0 * t + random_phase'), 1);
x_schroeder = sum(Ak .* cos(2 * pi * k' * f0 * t + schroeder_phase'), 1);

% Compute FFTs
X_constant = fft(x_constant);
X_random = fft(x_random);
X_schroeder = fft(x_schroeder);

% Frequency axis
freqs = (0:N-1) * (fs / N);

% Plot time-domain signals
figure;
subplot(3,1,1);
plot(t, x_constant);
title('Multisine - Constant Phase');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(3,1,2);
plot(t, x_random);
title('Multisine - Random Phase');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(3,1,3);
plot(t, x_schroeder);
title('Multisine - Schroeder Phase');
xlabel('Time (s)'); ylabel('Amplitude');

% Plot frequency-domain signals
figure;
subplot(3,1,1);
plot(freqs, abs(X_constant));
title('FFT - Constant Phase');
xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(3,1,2);
plot(freqs, abs(X_random));
title('FFT - Random Phase');
xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(3,1,3);
plot(freqs, abs(X_schroeder));
title('FFT - Schroeder Phase');
xlabel('Frequency (Hz)'); ylabel('Magnitude');

% Compute crest factors
CF_constant = max(abs(x_constant)) / rms(x_constant);
CF_random = max(abs(x_random)) / rms(x_random);
CF_schroeder = max(abs(x_schroeder)) / rms(x_schroeder);

fprintf('Crest Factors:\n');
fprintf('Constant Phase: %.2f\n', CF_constant);
fprintf('Random Phase: %.2f\n', CF_random);
fprintf('Schroeder Phase: %.2f\n', CF_schroeder);
