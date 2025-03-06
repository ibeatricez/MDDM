% What is Conjugate Symmetry?
% For real-valued signals (time-domain signals like the ones we measure), the DFT has a special symmetry property:
% X(N-k) = X(-k) = X*(k)
% The negative frequency components are the complex conjugate of the positive frequency components.
% This is what makes the DFT redundant for real signals,the second half (negative frequencies) can be derived from the first half (positive frequencies).
% DFT is periodic with period N, Intuitive Meaning: Positive frequencies
% appear in bins k = to N/2, 
% Negative frequencies appear in bins k=N/2+1 to N-1,and they are mirror images (conjugate symmetric) of the positive side.

% Parameters
N = 10;          % Number of samples
t = (0:N-1)/100; % Time vector (assuming fs=100Hz)

% Generate a real-valued signal (cosine + noise)
x = cos(2*pi*5*t) + 0.2*randn(size(t));

% Compute DFT
X = fft(x);

% Conjugate symmetry check
k = 1:N/2;                         % Positive frequencies
neg_k = N:-1:N/2+1;                 % Negative frequencies (mirrored)

% Plot magnitudes to check symmetry
figure;
subplot(2,1,1);
stem(k-1, abs(X(k)), 'b', 'filled');          % Positive frequencies
hold on;
stem(-k+1, abs(X(neg_k)), 'r', 'filled');     % Negative frequencies (should match)
xlabel('Frequency Bin');
ylabel('Magnitude');
title('Checking Conjugate Symmetry - Magnitude');
legend('Positive Frequencies', 'Negative Frequencies');

% Plot phase to check symmetry
subplot(2,1,2);
stem(k-1, angle(X(k)), 'b', 'filled');          % Positive frequencies
hold on;
stem(-k+1, -angle(X(neg_k)), 'r', 'filled');    % Negative frequencies (should match conjugated)
xlabel('Frequency Bin');
ylabel('Phase (rad)');
title('Checking Conjugate Symmetry - Phase');
legend('Positive Frequencies', 'Negative Frequencies');

% Explanation message
disp('If the DFT is conjugate symmetric, the negative frequencies (red) should mirror the positive ones (blue).');