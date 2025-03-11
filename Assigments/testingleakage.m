f_test = 10;  % Select a frequency that fits exactly in window
t = (0:N1-1) / fs;
x_test = cos(2 * pi * f_test * t);

% Compute FFT
% Compute FFT correctly
X_test = fft(x_test);
X_test_mag = abs(X_test(1:N1/2+1));  % Only keep positive half
f = (0:N1/2) * (fs/N1);  % Positive frequency axis

% Convert to dB scale
X_dB = 20 * log10(X_test_mag + 1e-16); 

% Only plot frequency components with significant magnitude
threshold_dB = -200;  % Only show components above -200 dB
valid_indices = X_dB > threshold_dB;

% Plot cleaned-up spectrum
figure;
stem(f(valid_indices), X_dB(valid_indices), 'b', 'filled', 'MarkerSize', 4);
xlabel('Frequency (Hz)');
ylabel('|X(f)| (dB)');
title('Single Cosine FFT Test - Final Cleaned Up');
grid on;
