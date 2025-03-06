% Task 1.7.2 - Filtered Random Noise
% Requirements: Filter the noise using a 5th order Chebyshev Type I filter with: Passband edge: 5 Hz, Ripple: 2 dB, Sampling frequency: 100 Hz, Plot in: Time domain (seconds) and Frequency domain (Hz)

% Parameters
fs = 100;                % Sampling frequency (Hz)
N = 1000;                 % Number of samples
ripple = 2;               % Passband ripple (dB)
f_pass = 5;                % Passband edge frequency (Hz)

% Generate white Gaussian noise
x = randn(1, N);

% Design lowpass Chebyshev filter
[b, a] = cheby1(5, ripple, 2*f_pass/fs);

% Apply filter
x_filtered = filter(b, a, x);

% Compute DFT
X_filtered = fft(x_filtered);

% Frequency axis in Hz
f = (0:N-1) * (fs/N);
t = (0:N-1) / fs;  % Time in seconds

% ====== PLOTS ======
figure;

% Time domain plot
subplot(2,1,1);
plot(t, x_filtered);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Gaussian Noise - Time Domain');

% Frequency domain plot
subplot(2,1,2);
stem(f, abs(X_filtered), 'b', 'filled');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Filtered Gaussian Noise - Frequency Domain');
grid on;
