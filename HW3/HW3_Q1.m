clc;    clear;

Fs = 5000;        % sampling of frequency signal
delta_w = 2 * pi * 10^9;    % spacing of each impulse
wc = 2 * pi * 10^10;
freq = (-3 : 1/Fs : 3 - 1/Fs) .* delta_w;   % define range of freq comb
dt = Fs / length(freq);     % sampling of time signal
t = (-Fs/2 : dt : Fs/2 - dt) ./ (delta_w * 2 * pi); % define range of time signal

% A(jw)
A = (freq == (-2)*delta_w | freq == (-1)*delta_w | freq == 0 | freq == delta_w | freq == 2*delta_w);

% new range of frequency comb
freq2 = (-3 + wc/delta_w : 1/Fs : 3 + wc/delta_w - 1/Fs) * delta_w;
% A(jw) centered at wc = 2 * pi * 10^10
A2 = (freq2 == (-2)*delta_w + wc | freq2 == (-1)*delta_w + wc | freq2 == wc | freq2 == delta_w + wc | freq2 == 2*delta_w + wc);

% plotting
% original a(t)
a = ifftshift(ifft(ifftshift(A * Fs)));
subplot(3, 1, 1);
plot(t, a);
axis([-5 * 10^(-11), 5 * 10^(-11), -0.5, 1]);
title('original a(t)');
xlabel('t');
ylabel('a(t)');

% a(t) when A(jw) centered at 2 * pi * 10^10
a2 = ifftshift(ifft(ifftshift(A2 * Fs)));
subplot(3, 1, 2);
plot(t, a2);
axis([-5 * 10^(-11), 5 * 10^(-11), -0.5, 1]);
title('a(t) when A(jw) centered at 2*pi*10^{10}');
xlabel('t');
ylabel('a(t)');

% difference between both intensities
I = abs(a).^2;
I2 = abs(a2).^2;
subplot(3, 1, 3);
plot(t, I2 - I);
axis([-5 * 10^(-11), 5 * 10^(-11), -0.5, 0.5]);
title('Difference between both intensities');
xlabel('t');
ylabel('I1(t) - I2(t)');