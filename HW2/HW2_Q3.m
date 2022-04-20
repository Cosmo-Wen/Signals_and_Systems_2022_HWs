clc; clear;

% exp(-(t/t0)^2) = t0 * sqrt(pi) * exp(-ω^2 * t^2 / 4)

% Definitions
pico = 10^-12;  % define pico 

Fs = 5000;    % sampling frequency

% Constructing Pulses
t = (-5: 1/Fs: 5 - 1 / Fs) * pico;
a = 1*(t>-2 * pico)-1*(t>2 * pico);    % Square wave with T1 = 2ps
b = exp(-t.^2 / (1 * pico)^2);    % Gaussian pulse of t0 = 1ps

% Performing Convolution in time domain
c = conv(a, b) / Fs;
t1 = (-10 + 1 / Fs: 1/Fs: 10 - 1 / Fs) * pico;
subplot(2, 1, 1);
plot(t1, c);
hold on;

% Performing Convolution in freq domain
FT_a = fft(a);    % Fourier transform of the two signals
FT_b = fft(b);
FT_C = FT_a .* FT_b;    % A convolution B in time domain means A * B in frequency domain
C = ifftshift(abs(ifft(FT_C))) / Fs;    % Turn C from freq domain back to time domain
plot(t, C);
hold off;
title('Convolution in time and frequency domain');
axis([-5 * pico, 5 * pico, 0, 2]);
legend('c', 'C');
xlabel('t (s)');
ylabel('C (x)');

% Perform difference of c and C
dif = (length(t1) - length(t)) / 2;
c = c(dif + 1: length(t1) - dif);
t1 = t1(dif + 1: length(t1) - dif);
subplot(2, 1, 2);
plot(t1, C - c);
title('Difference between time and frequency domain');
axis([-5 * pico, 5 * pico, 0, 10^-4]);
legend('c - C');
xlabel('t (s)');
ylabel('c (x) - C (x)');