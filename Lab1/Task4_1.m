% Section 1.4 - Frequency Domain Construction of a Multisine.
% Up to now, we generated multisines directly in the time domain (by summing cosines). In this section, we’ll directly construct the DFT (frequency domain) and set the amplitudes and phases for each frequency directly in X(k) (the DFT).
% This allows for much more precise control, especially if you want very specific spectral properties.
% The trick given is to only define the positive frequencies X(k), and then use symmetry to fill in the negative frequencies.
% This works because real signals have a conjugate symmetric DFT.
% Set this for k = 1 to K (the excited bins), Set everything else (unexcited bins) to zero

% Task 1.4.1 asks us to prove and demonstrate the trick where we construct a multisine directly in the frequency domain by filling only the positive frequency bins, and then reconstructing the time domain signal via the iDFT.

% Parameters
N = 1000;                     % Number of samples
K = 30;                        % Number of excited frequencies
fs = 100;                      % Sampling frequency (Hz)

% Initialize X_tilde (frequency domain multisine)
X_tilde = zeros(1, N);         % Full DFT spectrum

% Set first K bins (positive frequencies only)
for k = 1:K
    phase = 2*pi*rand();       % Random phase for each frequency
    X_tilde(k+1) = (0.5) * exp(1j * phase);  % X_tilde uses k+1 because MATLAB indexing starts at 1
end

% Time domain reconstruction using the trick
x = 2 * N * real(ifft(X_tilde));

% Frequency axis in bins
k = 0:N-1;

% ====== Plot Results ======
figure;

% Time domain plot
subplot(2,1,1);
plot(0:N-1, x);
xlabel('Sample');
ylabel('Amplitude');
title('Time Domain Multisine (Constructed via Frequency Domain Trick)');

% Frequency domain plot (in bins)
subplot(2,1,2);
stem(k, abs(X_tilde), 'b', 'filled');
xlabel('Frequency Bin');
ylabel('|X̃(k)|');
title('Frequency Domain Multisine (Only Positive Bins Filled)');
grid on;

% X_tilde is the "half DFT", meaning it only has positive frequencies filled.
% ifft() transforms this into the time domain.
% We multiply by  2N and take real() to ensure the correct real-valued time-domain signal.
% This trick works perfectly when the signal is periodic (fits the DFT length).