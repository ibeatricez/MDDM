% Task 1.2.5 - Frequency Axis in Hz: convert the frequency axis from bins to Hz. 
% This is very practical because you often want to know at what actual frequency (in Hertz) each DFT bin corresponds to.
% The relation between bin number k and frequency f in Hz is: f_k =
% k*f_s/N

% Parameters
N = 1000;            % Number of samples
fs = 100;             % Sampling frequency (Hz)
Ts = 1/fs;

% Cosine signal - 3 periods in 1000 samples
num_periods = 3;
f_cos = num_periods / (N*Ts);   % Cosine frequency (Hz)
phi = 2*pi*rand();               % Random phase

% Time domain signal
t = (0:N-1) * Ts;
x = cos(2*pi*f_cos*t + phi);

% Compute DFT
X = fft(x);

% Frequency axis in Hz
f = (0:N-1) * (fs/N);

% Plot DFT magnitude with frequency axis in Hz
figure;
stem(f, abs(X), 'b', 'filled');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('DFT Magnitude (Frequency Axis in Hz)');
grid on;

% Highlight the peak frequency
[~, peak_bin] = max(abs(X(1:N/2)));  % Find main peak in the positive frequencies
hold on;
stem(f(peak_bin), abs(X(peak_bin)), 'r', 'LineWidth', 2);

legend('All Frequencies', 'Main Peak');
disp(['Cosine frequency: ', num2str(f_cos), ' Hz']);
disp(['Detected peak frequency: ', num2str(f(peak_bin)), ' Hz']);

% in result: Frequency axis is now shown in Hz instead of bins. The peak should appear exactly at the designed frequency (around f_cos).The red mark shows where MATLAB found the actual peak, this confirms that the cosine fits perfectly and there’s no leakage.
