clc;    clear;

Fs = 10000;        % sampling of frequency signal
delta_w = 2 * pi * 10^9;    % spacing of each impulse
wc = 2 * pi * 10^10;
freq = (-7 : 1/Fs : 7 - 1/Fs) .* delta_w;   % define range of freq comb
dt = Fs / length(freq);     % sampling of time signal
t = (-Fs/2 : dt : Fs/2 - dt) ./ (delta_w * 2 * pi); % define range of time signal

% A(jw)
A = (freq == (-2)*delta_w | freq == (-1)*delta_w | freq == 0 | freq == delta_w | freq == 2*delta_w);
Ar = (freq == (-6)*delta_w | freq == (-3)*delta_w | freq == 0 | freq == 3*delta_w | freq == 6*delta_w);

% new range of frequency comb
freq2 = (-7 + wc/delta_w : 1/Fs : 7 + wc/delta_w - 1/Fs) * delta_w;
% A(jw) centered at wc = 2 * pi * 10^10
A2 = ((freq2 == ((-2)*delta_w + wc)) | (freq2 == ((-1)*delta_w + wc)) | (freq2 == wc) | (freq2 == (delta_w + wc)) | (freq2 == (2*delta_w + wc)));
plot(freq2, A2);

%%
% plotting
% original a(t)
a = ifftshift(ifft(ifftshift(A)));
subplot(2, 2, 1);
plot(t, a);
axis([-10^(-10), 10^(-10), -1 * 10^(-4), 2 * 10^(-4)]);
title('original a(t)');
xlabel('t');
ylabel('a(t)');
ar = ifftshift(ifft(ifftshift(Ar)));
subplot(2, 2, 2);
plot(t, ar);
axis([-10^(-10), 10^(-10), -1 * 10^(-4), 2 * 10^(-4)]);
% a(t) when A(jw) centered at 2 * pi * 10^10
a2 = ifftshift(ifft(ifftshift(A2)));
subplot(2, 2, 3);
plot(t, a2);
axis([-10^(-10), 10^(-10), -1 * 10^(-4), 2 * 10^(-4)]);
title('a(t) when A(jw) centered at 2*pi*10^{10}');
xlabel('t');
ylabel('a(t)');

% difference between both intensities
I = abs(a).^2;
I2 = abs(a2).^2;
subplot(2, 2, 4);
plot(t, I2 - I);
axis([-5 * 10^(-11), 5 * 10^(-11), -2 * 10^(-8), 0.5 * 10^(-8)]);
title('Difference between both intensities');
xlabel('t');
ylabel('I1(t) - I2(t)');