% Task 1.3.3 - Excite Specific Frequency Lines: This time, instead of exciting the first 10 frequency bins, it is asked to generate a random phase multisine where the excited frequencies are:[4,8,12,16,20,24] Hz
% Parameters
N = 1000;                    % Number of samples
fs = 200;                     % Sampling frequency (Hz)
Ts = 1/fs;                    % Sampling period (seconds)
t = (0:N-1) * Ts;              % Time vector

% Frequencies to excite
excited_frequencies = [4, 8, 12, 16, 20, 24];  % In Hz

% Generate multisine (sum of cosines with random phase)
x = zeros(1, N);
for f = excited_frequencies
    phase = 2 * pi * rand();   % Random phase in [0, 2π]
    x = x + cos(2 * pi * f * t + phase);
end

% Compute DFT
X = fft(x);

% Frequency axis in Hz
f_axis = (0:N-1) * (fs/N);

% ====== PLOTS ======

% Time-domain plot (time in seconds)
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Random Phase Multisine - Time Domain');

% Frequency-domain plot (frequency in Hz)
subplot(2,1,2);
stem(f_axis, abs(X), 'b', 'filled');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Random Phase Multisine - Frequency Domain');
grid on;

% Highlight excited frequencies in red
hold on;
for f = excited_frequencies
    [~, idx] = min(abs(f_axis - f));  % Find closest bin to each target frequency
    stem(f_axis(idx), abs(X(idx)), 'r', 'LineWidth', 2);
end

legend('All Frequencies', 'Excited Frequencies');

% In result: This creates a signal with energy only at the specified 6 frequencies. 
% Phases are random, so every run gives a slightly different signal in time. 
% The frequency plot highlights the excited frequencies in red.