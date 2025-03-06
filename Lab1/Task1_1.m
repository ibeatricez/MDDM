% DTF(Discrete Time Fourier) converts a signal from the time domain into the frequency domain.
% This allows us to see which frequencies are present in the signal and with what amplitudes.
% The inverse DFT (iDFT), which reconstructs the time signal from the frequency domain
% Frequency Axis - Task 1.1

% Parameters
N = 10;          % Number of samples
fs = 100;          % Sampling frequency in Hz
Ts = 1/fs;         % Sampling period in seconds
T = N * Ts;        % Total duration of the signal in seconds

% Frequency axis in rad/s
k = 0:N-1;         % Frequency bins
omega = (2 * pi / T) * k;  % Frequency axis in rad/s

% Display results
disp('Frequency axis in rad/s:');
disp(omega);

% Plot the frequency axis for visualization
figure;
stem(k, omega);
xlabel('Frequency bin k');
ylabel('\omega_k (rad/s)');
title('Frequency axis in rad/s');
grid on;