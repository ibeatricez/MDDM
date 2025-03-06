% Section 1.7 - Random Noise Signals.
% This section focuses on generating random noise signals, which are another common type of excitation signal used in system identification.
% Task 1.7.1 - Generate White Gaussian Noise
% Length: N=1000 samples. Use randn() to generate normally distributed noise.Plot the noise in both: Time domain (samples) and Frequency domain (bins)

% Parameters
N = 1000;                % Number of samples
fs = 100;                 % Sampling frequency (Hz)

% Generate white Gaussian noise
x = randn(1, N);

% Compute DFT
X = fft(x);

% Frequency axis in bins
k = 0:N-1;

% ====== PLOTS ======
figure;

% Time domain plot
subplot(2,1,1);
plot(0:N-1, x);
xlabel('Sample');
ylabel('Amplitude');
title('White Gaussian Noise - Time Domain');

% Frequency domain plot (magnitude spectrum)
subplot(2,1,2);
stem(k, abs(X), 'b', 'filled');
xlabel('Frequency Bin');
ylabel('|X(k)|');
title('White Gaussian Noise - Frequency Domain');
grid on;
