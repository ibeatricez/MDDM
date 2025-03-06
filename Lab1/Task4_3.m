% Task 1.4.3 - Specified Excited Frequency Band (5Hz to 15Hz)
% Construct a frequency domain multisine. The excited frequencies should be between 5Hz and 15Hz. We need exactly 31 excited frequencies, spaced equally. Choose an appropriate sampling frequency.
% Plot: Time-domain signal (time axis in seconds).Frequency-domain signal (frequency axis in Hz)
% Finally, compute: The period (T) of the multisine (in seconds). The frequency resolution (Δf) in Hz.
% 31 equidistant frequencies in the range [5Hz, 15Hz] means: f=linspace(5,15,31)
% This gives 31 frequencies including both 5Hz and 15Hz.

% Parameters
N = 1000;                % Number of samples
fs = 100;                 % Sampling frequency (Hz)
Ts = 1/fs;                 % Sampling period (s)
f_start = 5;               % Start frequency (Hz)
f_end = 15;                 % End frequency (Hz)
num_freqs = 31;             % Number of excited frequencies

% Time vector
t = (0:N-1) * Ts;

% Frequency vector (equally spaced within 5 to 15 Hz)
excited_frequencies = linspace(f_start, f_end, num_freqs);

% Initialize DFT spectrum (frequency domain multisine)
X = zeros(1, N); 

% Fill DFT at the bins corresponding to the excited frequencies
for f = excited_frequencies
    phase = 2*pi*rand();  % Random phase
    bin = round(f * N / fs);  % Convert frequency to bin index
    X(bin+1) = 0.5 * exp(1j * phase);  % Set positive frequency bin
end

% Use conjugate symmetry for real time-domain signal
X(N:-1:N-num_freqs+1) = conj(X(2:num_freqs+1));

% Inverse DFT to get time domain signal
x = real(ifft(X) * N);

% Frequency axis in Hz
f_axis = (0:N-1) * (fs/N);

% ====== PLOTS ======

% Time domain plot (time axis in seconds)
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Random Phase Multisine (5Hz to 15Hz) - Time Domain');

% Frequency domain plot (frequency axis in Hz)
subplot(2,1,2);
stem(f_axis, abs(X), 'b', 'filled');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Random Phase Multisine (5Hz to 15Hz) - Frequency Domain');
grid on;

% Highlight the excited frequencies
hold on;
for f = excited_frequencies
    [~, idx] = min(abs(f_axis - f));  % Find the closest frequency bin
    stem(f_axis(idx), abs(X(idx)), 'r', 'LineWidth', 2);
end
legend('All Frequencies', 'Excited Frequencies');

% ====== Period and Frequency Resolution ======
T = N * Ts;                         % Total signal duration = period (in seconds)
delta_f = fs / N;                    % Frequency resolution (Hz)

disp(['Period of the multisine: ', num2str(T), ' seconds']);
disp(['Frequency resolution: ', num2str(delta_f), ' Hz']);

% We build the spectrum directly by placing non-zero values at exactly the desired frequencies.
% Each excited frequency gets a random phase.
% The inverse FFT gives you the time-domain signal.
% The plot highlights the excited frequencies in red, and the rest of the spectrum is zero.