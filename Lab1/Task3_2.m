% Task 1.3.2 - Frequency Axis in Hz: For the multisine we just created (Task 1.3.1), 
% we now need to: Plot the DFT magnitude with the x-axis labeled in Hz (not bins). 
% Also, plot the time-domain signal again, but with the time axis in seconds.

% Parameters
N = 1000;            % Number of samples
K = 10;               % Number of excited frequencies
fs = 100;             % Sampling frequency (Hz)
Ts = 1/fs;            % Sampling time (s)

% Time vector
t = (0:N-1) * Ts;

% Generate multisine - sum of cosines with random phase
x = zeros(1, N);

for k = 1:K
    phase = 2*pi*rand();            % Random phase in [0, 2π]
    freq_bin = k;                    % Excited frequency bins: 1 to 10
    freq = (freq_bin) * fs / N;      % Frequency in Hz for this bin
    
    x = x + cos(2*pi*freq*t + phase); % Add cosine to multisine
end

% Compute DFT
X = fft(x);

% Frequency axis in Hz
f = (0:N-1) * (fs/N);

% Plot time domain signal (time in seconds)
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Random Phase Multisine - Time Domain');

% Plot frequency domain (frequency in Hz)
subplot(2,1,2);
stem(f, abs(X), 'b', 'filled');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Random Phase Multisine - Frequency Domain (Hz)');
grid on;

% In result: The time-domain plot shows time in seconds (not samples).
% The frequency-domain plot shows frequency in Hz (not bins).