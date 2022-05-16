clc;    clear;

Fs = 50;
delta_w = 2 * pi * 10^9;
wc = 2 * pi * 10^10;
freq = (-3 : 1/Fs : 3 - 1/Fs) * delta_w;
dt = Fs / length(freq);
t = (-Fs/2 : dt : Fs/2 - dt);

A = (freq == (-2)*delta_w | freq == (-1)*delta_w | freq == 0 | freq == delta_w | freq == 2*delta_w);
%plot(freq, A);

a = ifftshift(ifft(ifftshift(A * Fs)));
subplot(3, 1, 1);
plot(t, a);

freq2 = (-3 + wc/delta_w : 1/Fs : 3 + wc/delta_w - 1/Fs) * delta_w;
A2 = (freq2 == (-2)*delta_w + wc | freq2 == (-1)*delta_w + wc | freq2 == wc | freq2 == delta_w + wc | freq2 == 2*delta_w + wc);
a2 = ifftshift(ifft(ifftshift(A2 * Fs)));
subplot(3, 1, 2);
plot(t, a2);

I = abs(a).^2;
I2 = abs(a2).^2;
subplot(3, 1, 3);
plot(t, I2 - I);