% Section 1.3 - Time Domain Construction of a Multisine.
% A multisine is a signal made up of the sum of multiple cosines (or sines), each with a different frequency, amplitude, and phase.
% Task 1.3.1 - Generate a Random Phase Multisine (Time Domain)

% Parameters
N = 4096;            % Number of samples
K = 100;               % Number of excited frequencies
fs = 100;             % Sampling frequency (Hz)
Ts = 1/fs;            % Sampling time (s)

% Time vector
t = (0:N-1) * Ts;

% Generate multisine - sum of cosines
x = zeros(1, N);     % Initialize signal

% Loop over each excited frequency
for k = 1:K
    phase = 2*pi*rand();   % Random phase in [0, 2π]
    freq_bin = k;          % Frequency bin index (excite the first K bins)
    freq = (freq_bin) * fs / N;   % Convert bin to Hz
    
    x = x + cos(2*pi*freq*t + phase);  % Add cosine with random phase
end

% Compute DFT
X = fft(x);

% Frequency axis in bins
k = 0:N-1;

% Plot time domain signal
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Random Phase Multisine - Time Domain');

% Plot frequency domain (in bins)
subplot(2,1,2);
stem(k, abs(X), 'b', 'filled');
xlabel('Frequency Bin');
ylabel('|X(k)|');
title('Random Phase Multisine - Frequency Domain (Bins)');
grid on;

% This directly implements the multisine formula. Only the first 10 bins contain signal, the rest should be almost zero. The phases are random, so you will see different results each time you run the code.