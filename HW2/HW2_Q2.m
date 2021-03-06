clc; clear;

% exp(-(t/t0)^2) = t0 * sqrt(pi) * exp(-ω^2 * t^2 / 4)

% Definitions
pico = 10^-12;  % define pico 

Fs = 500000;    % sampling frequency

% Constructing Pulses
t1 = (-50: 1/Fs: 50 - 1 / Fs) * pico; 
t2 = (-5: 1/Fs: 5 - 1 / Fs) * pico;
x1 = exp(-t1.^2 / (10 * pico)^2);   % Gaussian pulse of t0 = 10ps
x2 = exp(-t2.^2 / (1 * pico)^2);    % Gaussian pulse of t0 = 1ps

% Constructing Frequency Scale
df1 = Fs / length(x1);   % frequency difference divided evenly regarding t1
df2 = Fs / length(x2);   % frequency difference divided evenly regarding t2
freq1 = (-Fs / 2: df1: Fs / 2 - df1) * 2 * pi / pico;    % set the scale to [-Fs / 2: Fs / 2) with regards to df1
freq2 = (-Fs / 2: df2: Fs / 2 - df2) * 2 * pi / pico;    % set the scale to [-Fs / 2: Fs / 2) with regards to df2

% Pulse Construction
%   For Both Instances:
%       1. Perform fast fourier transform
%       2. Shift by scaling exp(-jωt0) for t0 = 2ps with respect to frequency scale
%       3. Adjust for shift and scale of transformation
X1 = fft(fftshift(x1));    
X2 = fft(fftshift(x2));
X1_shift = X1 .* exp(1i * freq1 * 2 * pico);
X2_shift = X2 .* exp(1i * freq2 * 2 * pico);
x1_shift = ifftshift(ifft(X1_shift));
x2_shift = ifftshift(ifft(X2_shift));

% As obviously shown, the phase shift is exp(-jω(-2ps)) for both cases
% Identical phase shift for the same amount of shift in the time domain

% Plotting
% Plot 1: t0 = 10ps: Before and After Shift
subplot(2, 1, 1);
plot(t1, x1);
hold on;
plot (t1, x1_shift);
hold off;
title('x1(t0 = 10ps) and shifted -2ps');
legend('x1(t)', 'x1 shifted'); 
xlabel('t (s)');
ylabel('x1(t)');

% Plot 2: t0 = 1ps: Before and After Shift
subplot(2, 1, 2);
plot(t2, x2);
hold on;
plot(t2, x2_shift);
hold off;
title('x2(t0 = 1ps) and shifted -2ps');
legend('x2(t)', 'x2 shifted'); 
xlabel('t (s)');
ylabel('x2(t)');