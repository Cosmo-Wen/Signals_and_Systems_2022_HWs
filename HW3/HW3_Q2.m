clc;    clear;

Fs = 5000;

wr = 2 * pi * 10^9;
t = -5: 1 / Fs: 5;

b1 = 2 * pi;
e1 = exp(1i * b1 * sin(wr * t));
E1 = fftshift(fft(fftshift(e1))) / Fs;

b2 = 4 * pi;
e2 = exp(1i * b2 * sin(wr * t));
E2 = fftshift(fft(fftshift(e2))) / Fs;

E3 = abs(E1) .* exp(1i * angle(E1));
E4 = abs(E2) .* exp(1i * angle(E2));

e3 = ifftshift(ifft(ifftshift(E3 * Fs)));
e4 = ifftshift(ifft(ifftshift(E4 * Fs)));

subplot(3, 3, 1);
plot(t, abs(e1).^2);
subplot(3, 3, 2);
plot(freq, abs(E1));
subplot(3, 3, 3);
plot(freq, angle(E1));
subplot(3, 3, 4);
plot(freq, abs(E2));
subplot(3, 3, 5);
plot(freq, angle(E2));
subplot(3, 3, 7);
plot(freq, abs(e3).^2);
subplot(3, 3, 8);
plot(freq, abs(e4).^2);