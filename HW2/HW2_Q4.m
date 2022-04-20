clc, clear;

micro = 10^-6;  % define micro

Fs = 50000;    % sampling freqency

% Constructing pulses
t = (-5: 1/Fs: 5 - 1/Fs) * micro;
g = exp(-t.^2 / (1 * micro)^2); % Gaussian pulse t0 = 1us
p = cos(2*pi*10^7.*t); % Cosine wave
r = g .* p;     % r(t) = g(t)p(t)

% Constructing frequency scale
df1 = Fs / length(g);   % frequency difference divided evenly regarding g
df2 = Fs / length(p);   % frequency difference divided evenly regarding p
df3 = Fs / length(r);   % frequency difference divided evenly regarding r
freq1 = (-Fs / 2: df1: Fs / 2 - df1) * 2 * pi / micro;  % set the scale to [-Fs / 2: Fs / 2) with regards to df1
freq2 = (-Fs / 2: df2: Fs / 2 - df2) * 2 * pi / micro;  % set the scale to [-Fs / 2: Fs / 2) with regards to df2
freq3 = (-Fs / 2: df3: Fs / 2 - df3) * 2 * pi / micro;  % set the scale to [-Fs / 2: Fs / 2) with regards to df3

G = fftshift(abs(fft(g))) / Fs * micro;     % Fourier transform of g(t)
P = fftshift(abs(fft(p))) / Fs * micro;     % Fourier transform of p(t)
R1 = fftshift(abs(fft(r))) / Fs * micro;    % Fourier transform of r(t)

R2 = (conv(G, P) * (df1 * 2 * pi / micro)) / (2*pi);    % Convolution of G, P and divided the result by 2*pi
freq4 = (-Fs: df1: Fs - df1) * 2 * pi / micro;    % set the scale to [-Fs : Fs) because of convolution
dif = (length(freq4) - length(freq3)) / 2;  % calculate margin
R2 = R2(dif + 1: length(freq4) - dif);  % parse margin of R2
freq4= freq4(dif + 1: length(freq4) - dif); % parse margin of freq4

% Because we use DT convolution to calculate CT convolution
% We should multiply the result by the interval of the DT signals

% R1 is obtained by fourier transform of r(t)
% R2 is obtained by multiply 1/2*pi to the convolution of G(jw) and P(jw)
% plot both R1 and R2 to prove that their results are same

% Plot 1: r(t)
subplot(3, 1, 1);
plot(t, r);
title('r(t)');
legend('r(t)');
xlabel('t (s)');
ylabel('r(t)');

% Plot 2: fourier transform of r(t)
subplot(3, 1, 2);
plot(freq3, R1);
hold on;
plot(freq4, R2);
hold off;
axis([-100 / micro, 100 / micro, 0, 1 * micro]);
title('R1: Fourier Transform of r(t)');
legend('R1', 'R2');
xlabel('ω (rad/s)');
ylabel('Magnitude');

% Plot 3: 1/(2*pi) * conv(G(jw), P(jw))
subplot(3, 1, 3);
plot(freq4, R2 - R1);
axis([-100 / micro, 100 / micro, 0, 1 * micro * micro * micro]);
title('Difference between R1 R2');
xlabel('ω (rad/s)');
ylabel('Magnitude');