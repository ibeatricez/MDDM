% The fundamental frequency ω_1 is the frequency associated with the first non-zero frequency bin (k=1). 
% From the formula: w_1 = 2*pi/T, Ts = N*T, Ts = 1/fs, w_1 = 2*pi*fs/N
% This uses fs (sampling frequency) and N (number of samples).
% This is the frequency resolution of your DFT, meaning the spacing between consecutive frequency bins.
% This task 1.1.2 only asks for one specific frequency — the fundamental frequency. 

% Parameters
N = 10;          % Number of samples
fs = 100;          % Sampling frequency in Hz

% Fundamental frequency in rad/s
omega1 = 2 * pi * fs / N;

% Display result
disp(['Fundamental frequency ω1 = ', num2str(omega1), ' rad/s']);

k = 0:N-1;
omega = (2 * pi / (N * (1/fs))) * k;
disp(['Check ω1 = ', num2str(omega(2)), ' rad/s']);

% Plotting omega nad omega1 = omega(2
figure;
stem(k, omega, 'b', 'filled');           % Plot omega (full frequency axis) in blue
hold on;
stem(1, omega1, 'r', 'LineWidth', 2);    % Highlight omega1 (fundamental frequency) in red

% Labels and title
xlabel('Frequency bin k');
ylabel('Frequency (rad/s)');
title('Full Frequency Axis and Fundamental Frequency');
legend('All Frequencies (omega)', 'Fundamental Frequency (omega1)');
grid on;

% Show numeric result in command window
disp(['Fundamental frequency ω1 = ', num2str(omega1), ' rad/s']);
% The result: a single value omega1, the smallest frequency step your DFT can resolve.