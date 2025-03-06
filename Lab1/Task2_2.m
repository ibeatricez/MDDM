% Task 1.2.2 - Check Perfect Reconstruction and Leakage
% When you fit exactly an integer number of periods into the sampled signal (the time window), the DFT will show energy at exactly one frequency bin (and its symmetric pair), no "leakage" into neighboring bins. This is called perfect reconstruction in the frequency domain.
% If the cosine’s period does not fit perfectly in the signal window, the DFT will "smear" the energy across multiple bins, this is leakage. It makes spectral analysis much harder because you can’t easily identify the signal’s true frequency.
% What to Check in the Plot?
% If perfect reconstruction happens: the DFT should show two very sharp peaks (at positive and negative frequencies).
% If leakage happens: the DFT would show spread energy into neighboring bins, forming a "side lobe".

% Parameters
N = 1000;            % Total samples
fs = 100;             % Sampling frequency (Hz)
Ts = 1/fs;            % Sampling time (seconds)
T = N * Ts;           % Total duration (seconds)

% Frequency and Phase
num_periods = 3;                    % 3 periods in the whole signal
f_cos = num_periods / T;            % Frequency of the cosine(multiple with 10.34 to see leakage)
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

% Check for leakage
disp('Checking for leakage...');

% Identify the peak and check the neighboring bins
main_bin = peak_bin;              % Main frequency bin (where the peak occurs)

% Look at neighboring bins
leakage_detected = false;
leakage_threshold = 1e-3 * max(abs(X)); % Very small allowed energy in neighboring bins

if main_bin > 1 && (abs(X(main_bin-1)) > leakage_threshold || abs(X(main_bin+1)) > leakage_threshold)
    leakage_detected = true;
end

% Output result
if leakage_detected % If you mess up the frequency slightly (try changing f_cos to something like 3.1 cycles in 1000 samples)
    disp('⚠️ Leakage detected! Energy spilled into neighboring bins.');
else
    disp('✅ Perfect reconstruction: no leakage detected.');
end