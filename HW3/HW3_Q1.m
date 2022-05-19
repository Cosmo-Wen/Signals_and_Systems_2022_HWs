clc;    clear;

Fs = 10;        % sampling of frequency signal
delta_w = 2 * pi * 10^9;    % spacing of each impulse
wc = 2 * pi * 10^10;
freq = (-100 : 1/Fs : 100 - 1/Fs) .* delta_w;   % define range of freq comb
dt = Fs / length(freq);     % sampling of time signal
t = (-Fs/2 : dt : Fs/2 - dt) ./ (delta_w * 2 * pi); % define range of time signal

% A(jw)
A = (freq == (-2)*delta_w | freq == (-1)*delta_w | freq == 0 | freq == delta_w | freq == 2*delta_w);
Ar = (freq == (-6)*delta_w | freq == (-3)*delta_w | freq == 0 | freq == 3*delta_w | freq == 6*delta_w);

% new range of frequency comb
freq2 = freq;
% A(jw) centered at wc = 2 * pi * 10^10
A2 = ((freq2 == ((-2)*delta_w + wc)) | (freq2 == ((-1)*delta_w + wc)) | (freq2 == wc) | (freq2 == (delta_w + wc)) | (freq2 == (2*delta_w + wc)));

stem(freq2, A2);