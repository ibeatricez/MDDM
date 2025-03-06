% 1.2 DFT of a Cosine: This section helps us to understand what the DFT of a simple cosine looks like. 
% A cosine in the time domain corresponds to two spikes in the frequency domain, one at the positive frequency, and one at the negative frequency.
% Create a cosine with random phase, such that exactly 3 periods fit into N = 100 samples.

% Parameters
N = 100;            % Total samples
fs = 100;             % Sampling frequency (Hz)
Ts = 1/fs;            % Sampling time (seconds)
T = N * Ts;           % Total duration (seconds)

% Frequency and Phase
num_periods = 3;                    % 3 periods in the whole signal
f_cos = num_periods / T;            % Frequency of the cosine
phi = 2*pi*rand();                   % Random phase in [0, 2π]

% Time vector
t = (0:N-1) * Ts;

% Generate cosine signal
x = cos(2*pi*f_cos*t + phi);

% Compute DFT
X = fft(x);

% Frequency axis in Hz (for plotting)
f = (0:N-1) * (fs/N);

% Plot time domain signal
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Cosine signal (3 periods)');

% Plot DFT (magnitude and phase)
subplot(2,1,2);
stem(f, abs(X)); hold on;
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('DFT Magnitude of Cosine');

% Highlight peak (cosine frequency)
[~, peak_bin] = max(abs(X(1:N/2)));  % Find main peak in the first half (positive frequencies)
stem(f(peak_bin), abs(X(peak_bin)), 'r', 'LineWidth', 2);

% Phase plot
figure;
stem(f, angle(X));
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
title('DFT Phase of Cosine');

disp(['Cosine frequency: ', num2str(f_cos), ' Hz']);
disp(['Detected peak at bin: ', num2str(peak_bin), ' corresponding to frequency: ', num2str(f(peak_bin)), ' Hz']);
