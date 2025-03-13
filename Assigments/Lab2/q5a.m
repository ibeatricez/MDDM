clear; clc; close all;

%% Define parameters
N = 4096;   % Number of time samples
K = 100;    % Number of excited spectral lines
fs = 8000;  % Sampling frequency in Hz
f0 = fs / N; % Fundamental frequency

%% Frequency axis (in bins)
k = (1:K)'; % First K frequency bins

%% Define amplitude and phase spectra
Ak = ones(K, 1); % Constant amplitude
random_phase = 2 * pi * rand(K, 1); % Random phase spectrum
schroeder_phase = (k .* (k + 1) * pi) / K; % Schroeder phase spectrum

%% Initialize DFT spectrum (X) with zeros
X_constant = zeros(N, 1);
X_random = zeros(N, 1);
X_schroeder = zeros(N, 1);

%% Assign nonzero frequencies in the positive half
X_constant(k+1) = (Ak / 2) .* exp(1j * 0); % Constant phase (zero)
X_random(k+1) = (Ak / 2) .* exp(1j * random_phase);
X_schroeder(k+1) = (Ak / 2) .* exp(1j * schroeder_phase);

%% Assign symmetric conjugate frequencies for real signal
X_constant(N-k+1) = conj(X_constant(k+1));
X_random(N-k+1) = conj(X_random(k+1));
X_schroeder(N-k+1) = conj(X_schroeder(k+1));

%% Compute inverse FFT to obtain time-domain signals (with proper scaling)
x_constant = real(ifft(X_constant) * N);
x_random = real(ifft(X_random) * N);
x_schroeder = real(ifft(X_schroeder) * N);

%% Time vector
t = (0:N-1) / fs;

%% Frequency vector (up to Nyquist frequency)
freqs = (0:N/2-1) * (fs / N);

%% Compute FFTs for analysis (only up to Nyquist frequency)
Xc = fft(x_constant) / N;
Xr = fft(x_random) / N;
Xs = fft(x_schroeder) / N;

%% Plot time-domain signals
figure;
subplot(3,1,1);
plot(t, x_constant);
title('Multisine (Time Domain) - Constant Phase');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(3,1,2);
plot(t, x_random);
title('Multisine (Time Domain) - Random Phase');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(3,1,3);
plot(t, x_schroeder);
title('Multisine (Time Domain) - Schroeder Phase');
xlabel('Time (s)'); ylabel('Amplitude');

%% Plot frequency-domain signals (only positive frequencies)
figure;
subplot(3,1,1);
plot(freqs, abs(Xc(1:N/2)));
title('FFT - Constant Phase');
xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(3,1,2);
plot(freqs, abs(Xr(1:N/2)));
title('FFT - Random Phase');
xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(3,1,3);
plot(freqs, abs(Xs(1:N/2)));
title('FFT - Schroeder Phase');
xlabel('Frequency (Hz)'); ylabel('Magnitude');

%% Compute Crest Factors
CF_constant = max(abs(x_constant)) / rms(x_constant);
CF_random = max(abs(x_random)) / rms(x_random);
CF_schroeder = max(abs(x_schroeder)) / rms(x_schroeder);

fprintf('Crest Factors:\n');
fprintf('Constant Phase: %.2f\n', CF_constant);
fprintf('Random Phase: %.2f\n', CF_random);
fprintf('Schroeder Phase: %.2f\n', CF_schroeder);
