% Section 1.6 - Influence of the Phase of a Multisine
% This task is about understanding how the choice of phase in a multisine affects its time-domain properties, particularly the Crest Factor (CF).
% The Crest Factor is the ratio of the peak amplitude to the RMS value
% A low crest factor means the signal energy is well spread out in time.
% A high crest factor means the signal has sharp peaks, this can be problematic in practical systems (amplifiers, actuators, etc.).

% Task 1.6.1 Requirements: 
% Create a multisine with N = 500 samples and the first 60 bins excited.
% Compute and plot time domain and frequency domain signals for these 4 phase choices:
% Random phase (each phase ∈ [0, 2π])
% Schroeder phase formula, Linear phase, constant phase(all phases zero)
%For each signal, compute and print the Crest Factor.
% Parameters
N = 500;                % Number of samples
K = 60;                  % Number of excited frequencies
fs = 100;                 % Sampling frequency (Hz)
Ts = 1/fs;

% Time vector
t = (0:N-1) * Ts;

% Initialize frequency domain vector
X = zeros(1, N);

% Initialize storage for all signals and crest factors
x_signals = zeros(4, N);
crest_factors = zeros(1, 4);

% 1. Random Phase Multisine
X = zeros(1, N);
for k = 1:K
    phase = 2*pi*rand();
    X(k+1) = 0.5 * exp(1j * phase);
end
X(N:-1:N-K+1) = conj(X(2:K+1));
x_signals(1, :) = real(ifft(X) * N);
crest_factors(1) = max(abs(x_signals(1, :))) / rms(x_signals(1, :));

% 2. Schroeder Phase Multisine
X = zeros(1, N);
for k = 1:K
    phase = (k*(k+1)*pi)/K;
    X(k+1) = 0.5 * exp(1j * phase);
end
X(N:-1:N-K+1) = conj(X(2:K+1));
x_signals(2, :) = real(ifft(X) * N);
crest_factors(2) = max(abs(x_signals(2, :))) / rms(x_signals(2, :));

% 3. Linear Phase Multisine
X = zeros(1, N);
for k = 1:K
    phase = k * pi;
    X(k+1) = 0.5 * exp(1j * phase);
end
X(N:-1:N-K+1) = conj(X(2:K+1));
x_signals(3, :) = real(ifft(X) * N);
crest_factors(3) = max(abs(x_signals(3, :))) / rms(x_signals(3, :));

% 4. Constant Phase Multisine
X = zeros(1, N);
for k = 1:K
    phase = 0;
    X(k+1) = 0.5 * exp(1j * phase);
end
X(N:-1:N-K+1) = conj(X(2:K+1));
x_signals(4, :) = real(ifft(X) * N);
crest_factors(4) = max(abs(x_signals(4, :))) / rms(x_signals(4, :));

% Plotting
labels = {'Random Phase', 'Schroeder Phase', 'Linear Phase', 'Constant Phase'};
figure;

for i = 1:4
    % Time domain plot
    subplot(4,2,2*i-1);
    plot(t, x_signals(i, :));
    xlabel('Time (s)');
    ylabel('Amplitude');
    title([labels{i} ' - Time Domain']);
    
    % Frequency domain plot
    X_plot = fft(x_signals(i, :)) / N;
    subplot(4,2,2*i);
    stem((0:N-1) * (fs/N), abs(X_plot), 'b', 'filled');
    xlabel('Frequency (Hz)');
    ylabel('|X(f)|');
    title([labels{i} ' - Frequency Domain']);
end

% Display Crest Factors
disp('Crest Factors for Each Phase Choice:');
for i = 1:4
    disp([labels{i} ': CF = ' num2str(crest_factors(i))]);
end


% in result: Each type of phase setting creates a slightly different time-domain signal.
% The Schroeder phase is known to minimize the crest factor — it "spreads" the energy evenly across time.
% We can compare all 4 in time and frequency domain, and see how the Crest Factor changes.

