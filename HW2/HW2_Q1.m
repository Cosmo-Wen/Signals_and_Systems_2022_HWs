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

% Fourier Transformation
%   For Both Instances:
%       1. Perform fast fourier transform
%       2. Mirror 2pi(f) to (-f), and shift by fftshift
%       3. Adjust for scale of integral
X1 = fftshift(abs(fft(x1))) / Fs * pico;    
X2 = fftshift(abs(fft(x2))) / Fs * pico;

% Plotting
% Plot 1: t0 = 10ps
subplot(2, 2, 1);
plot(t1, x1);
title('x1(t0 = 10ps)');
legend('x1(t)'); 
xlabel('t (s)');
ylabel('x1(t)');

% Plot 2: t0 = 1ps
subplot(2, 2, 2);
plot(t2, x2);
title('x2(t0 = 1ps)');
legend('x2(t)'); 
xlabel('t (s)');
ylabel('x2(t)');

% Plot 3: Fourier Transform of x1(t)
subplot(2, 2, 3);
plot(freq1, X1);
axis([(-1 / pico) (1 / pico) 0 (20 * pico)]);
title('Fourier Transform of x1(t): X1(jω)');
legend('X1(jω)'); 
xlabel('ω (rad/s)');
ylabel('Magnitude of X1(jω)');

% Plot 4: Fourier Transform of x2(t)
subplot(2, 2, 4);
plot(freq2, X2);
 axis([(-10 / pico) (10 / pico) 0 (2 * pico)]);
title('Fourier Transform of x2(t): X2(jω)');
legend('X2(jω)'); 
xlabel('ω (rad/s)');
ylabel('Magnitude of X2(jω)');