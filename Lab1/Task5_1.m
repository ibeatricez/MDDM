% Section 1.5 - Setting the RMS of a Signal: The goal here is to scale your signal so that it has a desired Root Mean Square (RMS) value.
% This is very common in practice when you want to control the input power of an excitation signal.
% Take the multisine you generated in Task 1.4.3.
% Set its RMS to: RMS_des=3, Plot both the original signal and the scaled signal in the time domain for comparison.

% Parameters
N = 1000;                % Number of samples
fs = 100;                 % Sampling frequency (Hz)
Ts = 1/fs;                 % Sampling period (s)
f_start = 5;               % Start frequency (Hz)
f_end = 15;                 % End frequency (Hz)
num_freqs = 31;             % Number of excited frequencies
RMS_des = 3;                % Desired RMS value

% Time vector
t = (0:N-1) * Ts;

% Generate original random phase multisine (same as Task 1.4.3)
X = zeros(1, N); 
excited_frequencies = linspace(f_start, f_end, num_freqs);

for f = excited_frequencies
    phase = 2*pi*rand();  % Random phase
    bin = round(f * N / fs);  % Convert frequency to bin index
    X(bin+1) = 0.5 * exp(1j * phase);  % Set positive frequency bin
end

% Use conjugate symmetry for real time-domain signal
X(N:-1:N-num_freqs+1) = conj(X(2:num_freqs+1));

% Inverse DFT to get time domain signal
x = real(ifft(X) * N);

% Compute original RMS
RMS_x = sqrt(mean(x.^2));

% Scale the signal to desired RMS
x_scaled = x * (RMS_des / RMS_x);

% Compute RMS of scaled signal (for verification)
RMS_x_scaled = sqrt(mean(x_scaled.^2));

% ====== PLOTS ======
figure;

% Original signal
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Original Multisine (RMS = ', num2str(RMS_x), ')']);

% Scaled signal
subplot(2,1,2);
plot(t, x_scaled);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Scaled Multisine (RMS = ', num2str(RMS_x_scaled), ')']);

% ====== Console Output ======
disp(['Original RMS: ', num2str(RMS_x)]);
disp(['Scaled RMS: ', num2str(RMS_x_scaled)]);
disp('Scaling complete.');

% in result: This takes your frequency domain multisine, transforms it to time domain. 
% Computes its original RMS. 
% Scales it to match the desired RMS (3).
% Plots both the original and scaled signals so you can visually confirm the change. 
% Prints the RMS values in the console.