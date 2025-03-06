% Task 1.2.4 - Frequency Axis in Bins: express the frequency axis directly in "bins" instead of Hz or rad/s
% What is a "Bin"? The DFT output X(k) consists of N bins, these are the
% discrete frequency points. Each bin corresponds to a unique frequency.
% Bin 1 (k=0) = DC (0 Hz). Bin N/2+1 = Nyquist frequency (fs/2 Hz). The
% spacing between bins is: delta f = fs/N

% Parameters
N = 1000;            % Number of samples
fs = 100;             % Sampling frequency (Hz)
Ts = 1/fs;

% Cosine signal - 3 periods fit into 1000 samples
num_periods = 3;
f_cos = num_periods / (N*Ts);     % Frequency in Hz
phi = 2*pi*rand();                 % Random phase

% Time domain signal
t = (0:N-1) * Ts;
x = cos(2*pi*f_cos*t + phi);

% Compute DFT
X = fft(x);

% Frequency axis in bins
k = 0:N-1;

% Plot DFT magnitude with frequency axis in bins
figure;
stem(k, abs(X), 'b', 'filled');
xlabel('Frequency Bin (k)');
ylabel('|X(k)|');
title('DFT Magnitude (Frequency Axis in Bins)');
grid on;

% Highlight main peaks
[~, peak_bin] = max(abs(X(1:N/2)));  % Main peak in first half (positive frequencies)
hold on;
stem(peak_bin, abs(X(peak_bin)), 'r', 'LineWidth', 2);
stem(N - peak_bin + 2, abs(X(N - peak_bin + 2)), 'r', 'LineWidth', 2);
legend('All Bins', 'Main Peaks');

% Frequency axis is in bin numbers (x-axis is k).
% Main peaks (cosine frequency and its conjugate) are highlighted in red.
% You can visually see that the signal content is concentrated at exactly 1 positive bin and 1 negative bin (symmetry).
% In result: Peak at bin 3 (which corresponds to 3 cycles in 1000 samples).
% Conjugate peak at bin 1000-3+2 (because MATLAB indexing starts at 1).