clc; clear;

% exp(-(t/t0)^2) = t0 * sqrt(pi) * exp(-w^2 * t^2 / 4)

Fs = 1000;
t1 = (-50: 1 / Fs: 50) * 10^-12;
t2 = (-5: 1 / Fs: 5) * 10^-12;
x1 = exp(-t1.^2 / (30*10^-12)^2);
x2 = exp(-t2.^2 / (10^-12)^2);
X1 = fftshift(abs(fft(x1)));
X2 = fftshift(abs(fft(x2)));
subplot(2, 2, 1)
plot(t1, x1);
subplot(2, 2, 2)
plot(t2, x2)
subplot(2, 2, 3)
plot(X1)
subplot(2, 2, 4)
plot(X2)