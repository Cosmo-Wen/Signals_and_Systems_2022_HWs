clc; clear;

% exp(-(t/t0)^2) = t0 * sqrt(pi) * exp(-ω^2 * t^2 / 4)

% Definitions
pico = 10^-12;  % define pico 

Fs = 500000;    % sampling frequency

% Constructing Pulses
t = (-5: 1/Fs: 5 - 1 / Fs) * pico;
t1 = (-5: 1/Fs: 5 - 1 / Fs) * pico;
a = 1*(t>-2 * pico)-1*(t>2 * pico);    % Square wave with T1 = 2ps
b = exp(-t1.^2 / (1 * pico)^2);    % Gaussian pulse of t0 = 1ps


% Performing Convolution in time domain
c = conv(a, b) / Fs;

% Performing Convolution in freq domain
FT_a = fft(a);    % Fourier transform of the two signals
FT_b = fft(b);
FT_C = FT_a .* FT_b;    % A convolution B in time domain means A * B in frequency domain
C = ifftshift(abs(ifft(FT_C))) / Fs;    % Turn C from freq domain back to time domain

% Plotting
% Plot 1: c
subplot(2, 1, 1);
plot(t1, c);
title('c = a conv b');
legend('c(t)'); 
xlabel('t (s)');
ylabel('c(t)');

% Plot 2: C
subplot(2, 1, 2);
plot(t1, c);
title('C(jw) = a(jw)*b(jw)');
legend('C(t)'); 
xlabel('t (s)');
ylabel('C(t)');
