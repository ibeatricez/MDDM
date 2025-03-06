% When you compute the DFT in MATLAB, at which indices do you see non-zero values for the cosine signal?
% This is directly related to the frequency axis interpretation, where does the DFT place frequencies?
% fft() returns a vector X of length N, corresponding to N frequency bins.
% Bin 1 = k = 0 (DC)
% Bin 2 = k = 1 (First frequency component)
% Bin N/2+1 = Nyquist frequency

% Parameters
N = 1000;            % Number of samples
fs = 100;             % Sampling frequency (Hz)
Ts = 1/fs;
T = N*Ts;

% Cosine frequency (fits 3 periods in the full signal)
num_periods = 3;
f_cos = num_periods / T;
phi = 2*pi*rand();

% Time domain signal
t = (0:N-1) * Ts;
x = cos(2*pi*f_cos*t + phi);

% Compute DFT
X = fft(x);

% Frequency axis
f = (0:N-1) * (fs/N);

% Find non-zero bins
tolerance = 1e-6; % Small threshold for numerical precision
nonzero_bins = find(abs(X) > tolerance);

% Display result
disp('Non-zero frequency bins:');
disp(nonzero_bins');

% Convert bins to Hz
nonzero_frequencies = f(nonzero_bins);
disp('Corresponding frequencies (Hz):');
disp(nonzero_frequencies');

% Plot time and frequency domain
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Cosine Signal');

subplot(2,1,2);
stem(f, abs(X), 'b', 'filled');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('DFT Magnitude');
grid on;

% Highlight the non-zero bins in red
hold on;
stem(nonzero_frequencies, abs(X(nonzero_bins)), 'r', 'LineWidth', 2);
legend('All Bins', 'Non-zero bins');

% In result: Non-zero bins at exactly the positive frequency of the cosine and its conjugate negative frequency.
% Everything else should be zero (or numerically very small).
% What to learn: How DFT bins map to physical frequencies (Hz) and understanding which bins carry actual signal content