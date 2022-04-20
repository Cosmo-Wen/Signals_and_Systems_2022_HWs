clc;    clear;
%%
%     不知道
%     108060002  周廷紘
%     109060035  温柏崴
%     109060044  莊凱威

%% Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1

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

%% Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2


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
X1 = fft(x1);    
X2 = fft(x2);
X1_shift = X1 .* exp(1i * freq1 * 2 * pico);
X2_shift = X2 .* exp(1i * freq2 * 2 * pico);
x1_shift = abs(ifft(X1_shift));
x2_shift = abs(ifft(X2_shift));
X1 = fftshift(abs(fft(x1))) / Fs * pico;    
X2 = fftshift(abs(fft(x2))) / Fs * pico;
X1_shift = fftshift(abs(X1_shift)) / Fs * pico;
X2_shift = fftshift(abs(X2_shift)) / Fs * pico;

% Plotting
% Plot 1: t0 = 10ps: Before and After Shift
subplot(2, 2, 1);
plot(t1, x1);
hold on;
plot (t1, x1_shift);
hold off;
title('x1(t0 = 10ps) and shifted -2ps');
legend('x1(t)', 'x1 shifted'); 
xlabel('t (s)');
ylabel('x1(t)');

% Plot 2: t0 = 1ps: Before and After Shift
subplot(2, 2, 2);
plot(t2, x2);
hold on;
plot(t2, x2_shift);
hold off;
title('x2(t0 = 1ps) and shifted -2ps');
legend('x2(t)', 'x2 shifted'); 
xlabel('t (s)');
ylabel('x2(t)');

% Plot 3: Fourier Transform of x1(t): Before and After Shift
subplot(2, 2, 3);
plot(freq1, X1);
hold on;
plot(freq1, X1_shift);
hold off;
axis([(-1 / pico) (1 / pico) 0 (20 * pico)]);
title('Phase of x1 and x1 shifted');
legend('X1(jω)', 'X1 shifted'); 
xlabel('ω (rad/s)');
ylabel('Magnitude of X1(jω)');

% Plot 4: Fourier Transform of x2(t): Before and After Shift
subplot(2, 2, 4);
plot(freq2, X2);
hold on;
plot(freq2, X2_shift);
hold off;
axis([(-10 / pico) (10 / pico) 0 (2 * pico)]);
title('Phase of x2 and x2 shifted');
legend('X2(jω)', 'X2 shifted'); 
xlabel('ω (rad/s)');
ylabel('Magnitude of X2(jω)');


%% Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3

clc; clear;

% exp(-(t/t0)^2) = t0 * sqrt(pi) * exp(-ω^2 * t^2 / 4)

% Definitions
pico = 10^-12;  % define pico 

Fs = 5000;    % sampling frequency

% Constructing Pulses
t = (-5: 1/Fs: 5 - 1 / Fs) * pico;
a = 1*(t>-2 * pico)-1*(t>2 * pico);    % Square wave with T1 = 2ps
b = exp(-t.^2 / (1 * pico)^2);    % Gaussian pulse of t0 = 1ps

% Performing Convolution in time domain
c = conv(a, b) / Fs;
t1 = (-10 + 1 / Fs: 1/Fs: 10 - 1 / Fs) * pico;
subplot(2, 1, 1);
plot(t1, c);
hold on;

% Performing Convolution in freq domain
FT_a = fft(a);    % Fourier transform of the two signals
FT_b = fft(b);
FT_C = FT_a .* FT_b;    % A convolution B in time domain means A * B in frequency domain
C = ifftshift(abs(ifft(FT_C))) / Fs;    % Turn C from freq domain back to time domain
plot(t, C);
hold off;
title('Convolution in time and frequency domain');
axis([-5 * pico, 5 * pico, 0, 2]);
legend('c', 'C');
xlabel('t (s)');
ylabel('C (x)');

% Perform difference of c and C
dif = (length(t1) - length(t)) / 2;
c = c(dif + 1: length(t1) - dif);
t1 = t1(dif + 1: length(t1) - dif);
subplot(2, 1, 2);
plot(t1, C - c);
title('Difference between time and frequency domain');
axis([-5 * pico, 5 * pico, 0, 10^-4]);
legend('c - C');
xlabel('t (s)');
ylabel('c (x) - C (x)');

%% Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4

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
