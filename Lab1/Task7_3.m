% Task 1.7.3 - Periodic Band-limited Random Noise
% Requirements: Generate a white noise signal.
% Set all DFT components beyond 5 Hz to zero.
% Use inverse FFT to create the time domain signal.
% Set desired RMS to 1.
% Concatenate multiple periods to create a periodic signal.
% Plot in: Time domain (seconds) and Frequency domain (Hz)

% Parameters
fs = 100;                % Sampling frequency (Hz)
N = 1000;                 % Number of samples
f_cutoff = 5;             % Cutoff frequency (Hz)
RMS_des = 1;              % Desired RMS value

% Generate white Gaussian noise
x = randn(1, N);

% Compute DFT
X = fft(x);

% Zero out frequencies above 5 Hz
f = (0:N-1) * (fs/N);
X(f > f_cutoff) = 0;

% Inverse FFT to get band-limited noise
x_bandlimited = real(ifft(X) * N);

% Scale to desired RMS
RMS_x = sqrt(mean(x_bandlimited.^2));
x_bandlimited = x_bandlimited * (RMS_des / RMS_x);

% Repeat to make periodic
x_periodic = repmat(x_bandlimited, 1, 3);  % Repeat 3 periods

% Compute DFT of periodic signal (for checking leakage)
X_periodic = fft(x_periodic);

% Frequency axis for repeated signal
N_periodic = length(x_periodic);
f_periodic = (0:N_periodic-1) * (fs/N_periodic);
t_periodic = (0:N_periodic-1) / fs;

% ====== PLOTS ======
figure;

% Time domain plot (periodic noise)
subplot(2,1,1);
plot(t_periodic, x_periodic);
xlabel('Time (s)');
ylabel('Amplitude');
title('Periodic Band-limited Random Noise - Time Domain');

% Frequency domain plot
subplot(2,1,2);
stem(f_periodic, abs(X_periodic), 'b', 'filled');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Periodic Band-limited Random Noise - Frequency Domain');
grid on;

% Confirm RMS
disp(['Final RMS: ', num2str(sqrt(mean(x_periodic.^2)))]);

% This gives us periodic band-limited noise with controlled RMS.
% The periodic nature ensures no leakage when taking DFT.
% The frequency plot should show a clear cutoff at 5 Hz.