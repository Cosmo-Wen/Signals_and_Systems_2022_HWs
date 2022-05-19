clc;    clear;

Fs = 1;        % sampling of frequency signal
delta_w = 2 * pi * 10^9;    % spacing of each impulse
wc = 2 * pi * 10^10;
freq = (-50 : 1/Fs : 50 - 1/Fs) .* delta_w;   % define range of freq comb
dt = Fs / length(freq);     % sampling of time signal
t = (-Fs/2 : dt : Fs/2 - dt).* 2 .* pi ./ (delta_w); % define range of time signal

% define A(jw)
A = (freq == (-2)*delta_w | freq == (-1)*delta_w | freq == 0 | freq == delta_w | freq == 2*delta_w);

% expanding A(jw) in frequency domain to compress a(t) in time domain
% define Ar(jw) as three times wider by A(jw) 
Ar = (freq == (-6)*delta_w | freq == (-3)*delta_w | freq == 0 | freq == 3*delta_w | freq == 6*delta_w);

% A(jw) centered at wc = 2 * pi * 10^10
% using circshift to shift the original A(jw) to center at wc
A2 = circshift(A, wc/delta_w);

% plotting
% original a(t)
a = ifftshift(ifft(ifftshift(A))) .* length(freq) ./ (2 .* pi);
subplot(3, 2, 1);
plot(t, a);
title('original a(t)');
xlabel('t');
ylabel('a(t)');

% a(t) with 3 repetition(three times narrower)
ar = ifftshift(ifft(ifftshift(Ar))) .* length(freq) ./ (2 .* pi);
subplot(3, 2, 2);
plot(t, ar);
title('a(t) with 3 repetition')
xlabel('t');
ylabel('a(t)');

% a(t) when A(jw) centered at 2 * pi * 10^10
a2 = ifftshift(ifft(ifftshift(A2))) .* length(freq) ./ (2 .* pi);
subplot(3, 2, 3);
plot(t, a2);
title('a(t) when A(jw) centered at 2*pi*10^{10}');
xlabel('t');
ylabel('a(t)');

% plotting both a(t)and a2(t)intensities
% by observing both graphs, we can determine that they are identical
I = abs(a).^2;
I2 = abs(a2).^2;
subplot(3, 2, 5);
plot(t, I);
title('I(t) = |a(t)|^2');
xlabel('t');
ylabel('I1(t)');
subplot(3, 2, 6);
plot(t, I2);
title('I2(t) = |a2(t)|^2');
xlabel('t');
ylabel('I2(t)');