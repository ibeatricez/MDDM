% Task 1.4.2 - Frequency Domain Multisine with 30 excited bins

% Parameters
N = 1000;                     % Number of samples
K = 30;                        % Number of excited bins
fs = 100;                      % Sampling frequency (Hz)

% Initialize DFT vector X
X = zeros(1, N);               % Full DFT spectrum (complex)

% Set first K bins (positive frequencies) with random phase and amplitude 1
for k = 1:K
    phase = 2*pi*rand();        % Random phase
    X(k+1) = 0.5 * exp(1j * phase);  % Set positive frequency (index k+1 because MATLAB indexing starts at 1)
end

% Use conjugate symmetry for real time-domain signal (FIXED)
X(N-K+1:N) = conj(fliplr(X(2:K+1)));

% Compute time domain signal using iDFT
x = real(ifft(X) * N);  % Ensure real output (due to symmetric spectrum)

% Frequency axis in bins
k = 0:N-1;

% Plot time domain signal
figure;
subplot(2,1,1);
plot(0:N-1, x);
xlabel('Sample');
ylabel('Amplitude');
title('Random Phase Multisine - Time Domain (Frequency Domain Constructed)');

% Plot frequency domain (in bins)
subplot(2,1,2);
stem(k, abs(X), 'b', 'filled');
xlabel('Frequency Bin');
ylabel('|X(k)|');
title('Random Phase Multisine - Frequency Domain (Bins)');
grid on;


% in result: We only define positive frequency bins (bins 1 to 30).
% The negative frequencies (bins 971 to 1000) are automatically filled in using conjugate symmetry.
% ifft() reconstructs the time-domain signal.
% You get perfect reconstruction because you only excite a subset of frequencies.