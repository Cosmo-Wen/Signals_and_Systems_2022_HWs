clc;    clear;
%%
%     不知道
%     108060002  周廷紘
%     109060035  温柏崴
%     109060044  莊凱威

% Text explanations are embedded into the codes for each problem as comments.
% They detail how and why the code are as it is, 
% and answers the questions/observations presented to us in the problems.

%% Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1
clc;    clear;

Fs = 1;        % sampling of frequency signal
delta_w = 2 * pi * 10^9;    % spacing of each impulse
wc = 2 * pi * 10^10;
freq = (-200 : 1/Fs : 200 - 1/Fs) .* delta_w;   % define range of freq comb
dt = Fs / length(freq);     % sampling of time signal
t = (-Fs/2 : dt : Fs/2 - dt) .* 2 .* pi ./ (delta_w); % define range of time signal

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

%% Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2
clc;    clear;

% Sampling Frequency
Fs = 500000;

% Δω = 2π * 10^9
dw = 2 * pi * 10^9;

% Set time and frequency scale
t = -10: 1 / Fs: 10;
df = Fs / length(t);
freq = (-Fs / 2: df: Fs / 2 - df) * 2 * pi;

% β = 2π
b1 = 2 * pi;

% epm(t) is purely a phase modulation,
% meaning for whatever β
% Magnitude of the Signal is always 1

% Construct e1 and its Fourier Transform
e1 = exp(1i * b1 * sin(dw * t));
E1 = fftshift(fft(fftshift(e1))) / Fs;

% β = 4π
b2 = 4 * pi;

% Construct e2 and its Fourier Transform
e2 = exp(1i * b2 * sin(dw * t));
E2 = fftshift(fft(fftshift(e2))) / Fs;

% By eliminating the phase of the signals,
% We extract the phase that counteracts the sinusoidal nature of Euler's identity
% Therefore introduces changes along magnitude = 1

% E3 = Magnitude of E1 and Phase of 0
E3 = abs(E1);
e3 = ifftshift(ifft(ifftshift(E3 * Fs)));

%  E4 = Magnitude of E2 and Phase of 0
E4 = abs(E2);
e4 = ifftshift(ifft(ifftshift(E4 * Fs)));

% Plot |e1|^2
subplot(3, 3, 1);
plot(t, abs(e1).^2);
title('|e1(t)|^2');
legend('|e1(t)|^2'); 
xlabel('t (s)');
ylabel('e1(t)');

% Plot Magnitude of E1
subplot(3, 3, 2);
plot(freq, abs(E1));
axis([-pi, pi, -1, 10]);
title('|E1(jw)|');
legend('|E1(jw)|'); 
xlabel('w (rad)');
ylabel('E1(jw)');

% Plot Phase of E1
subplot(3, 3, 3);
plot(freq, angle(E1));
title('∠E1(jw)');
legend('∠E1(jw)∠'); 
xlabel('w (rad)');
ylabel('ϕ');

% Plot Magnitude of E2
subplot(3, 3, 4);
plot(freq, abs(E2));
axis([-pi, pi, -1, 10]);
title('|E2(jw)|');
legend('|E2(jw)|'); 
xlabel('w (rad)');
ylabel('E2(jw)');

% Plot Phase of E2
subplot(3, 3, 5);
plot(freq, angle(E2));
title('∠E2(jw)');
legend('∠E2(jw)∠'); 
xlabel('w (rad)');
ylabel('ϕ');

% Plot |e3|^2
subplot(3, 3, 7);
plot(t, abs(e3).^2);
title('|e3(t)|^2');
legend('|e3(t)|^2'); 
xlabel('t (s)');
ylabel('e3(t)');

% Plot |e4|^2
subplot(3, 3, 8);
plot(t, abs(e4).^2);
title('|e4(t)|^2');
legend('|e4(t)|^2'); 
xlabel('t (s)');
ylabel('e4(t)');

%% Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3
clc;    clear;

% Sampling Frequency
Fs = 50000;

% Constructing time and frequency scale
t = 0: 1 / Fs: 0.1 - 1 / Fs;
df = Fs / length(t);
w = (-Fs / 2: df: Fs / 2 - df) * 2 * pi;

% Second Order Differential System
% y''(t) + 2ζω0 y'(t) + ω0^2 y(t) = ω0^2 x(t)
% (-ω^2 + 2ζω0(jω) + ω0^2) Y(jω) = ω0^2 X(jω)
% H(jω) = (ω0^2) / (-ω^2 + 2ζω0(jω) + ω0^2)

% ωn
wn = 100;

% Different ζ's
z1 = 0.5;
z2 = 1;
z3 = 1.5;

% Construct Fourier Transform for Impulse Responses
H1 = wn^2 ./ (-w.^2 + 2 * z1 * wn * 1i * w + wn^2);
H2 = wn^2 ./ (-w.^2 + 2 * z2 * wn * 1i * w + wn^2);
H3 = wn^2 ./ (-w.^2 + 2 * z3 * wn * 1i * w + wn^2);

% Impulse Responses by Inverse Fourier Transform
h1 = ifft(ifftshift(H1 * Fs));
h2 = ifft(ifftshift(H2 * Fs));
h3 = ifft(ifftshift(H3 * Fs));

% Plot Impulse Response of ζ = 0.5
subplot(3, 3, 1);
plot(t, h1);
title('Impulse Response h1(t)');
legend('h1(t)'); 
xlabel('t (s)');
ylabel('h1(t)');

% Plot Bode Magnitude of ζ = 0.5
subplot(3, 3, 2);
semilogx(w, 20 * log(abs(H1)));
title('Bode Plot Magnitude H1(jw)');
legend('|H1(jw)|'); 
xlabel('w (rad)');
ylabel('|H1(t)|');

% Plot Bode Phase of ζ = 0.5
subplot(3, 3, 3);
semilogx(w, angle(H1));
title('Bode Plot Phase H1(jw)');
legend('∠H1(jw)'); 
xlabel('w (rad)');
ylabel('∠H1(t)');

% Plot Impulse Response of ζ = 0.5
subplot(3, 3, 4);
plot(t, h2);
title('Impulse Response h2(t)');
legend('h2(t)'); 
xlabel('t (s)');
ylabel('h2(t)');

% Plot Bode Magnitude of ζ = 0.5
subplot(3, 3, 5);
semilogx(w, 20 * log(abs(H2)));
title('Bode Plot Magnitude H2(jw)');
legend('|H2(jw)|'); 
xlabel('w (rad)');
ylabel('|H2(t)|');

% Plot Bode Phase of ζ = 0.5
subplot(3, 3, 6);
semilogx(w, angle(H2));
title('Bode Plot Phase H2(jw)');
legend('∠H2(jw)'); 
xlabel('w (rad)');
ylabel('∠H2(t)');

% Plot Impulse Response of ζ = 0.5
subplot(3, 3, 7);
plot(t, h3);
title('Impulse Response h3(t)');
legend('h3(t)'); 
xlabel('t (s)');
ylabel('h3(t)');

% Plot Bode Magnitude of ζ = 0.5
subplot(3, 3, 8);
semilogx(w, 20 * log(abs(H3)));
title('Bode Plot Magnitude H3(jw)');
legend('|H3(jw)|'); 
xlabel('w (rad)');
ylabel('|H3(t)|');

% Plot Bode Phase of ζ = 0.5
subplot(3, 3, 9);
semilogx(w, angle(H3));
title('Bode Plot Phase H3(jw)');
legend('∠H3(jw)'); 
xlabel('w (rad)');
ylabel('∠H3(t)');

%% Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4Q4
clc;    clear;

dw = 2*pi*10^-3; 
% define dw

n = 0:1:60;
% define the range of n
w = -2*pi:dw:2*pi;
% define the range of w

h_0 = (n+1).*0.5.^n .* (n>=0);
h_5 = 0.5.^n.*(sin((n+1)*0.5*pi)/sin(0.5*pi)) .* (n>=0);
h_pi = (n+1).*(-0.5).^n .* (n>=0);
% according to Eqn.(6.66), the impulse response h[n] = (n + 1)((-r)^n)u[n]

H_0 = 1./(1-2*0.5*cos(0).*exp(-1j.*w)+0.5^2.*exp(-2j.*w));
H_5 = 1./(1-2*0.5*cos(0.5*pi).*exp(-1j.*w)+0.5^2.*exp(-2j.*w));
H_pi = 1./(1-2*0.5*cos(pi).*exp(-1j.*w)+0.5^2.*exp(-2j.*w));
% according to Eqn.(6.58), the frequency response H[n] = 1/(1 - 2rcosθ*e^(-jw) + r^2*e^(-2jw))


% Plotting
subplot(3,3,1)
stem(n,h_0)
title('Impulse Response When θ = 0'); 
xlabel('n');
ylabel('h[n]');

subplot(3,3,2)
plot(w,20*log10(H_0))
set(gca,'XTick',-2*pi:pi:2*pi)
set(gca,'XTickLabel',{'-2\pi','-\pi','0','\pi','2\pi'})
title('Bode Plots for θ = 0'); 
xlabel('w');
ylabel('20log|H(e^j^w)|');

subplot(3,3,3)
plot(w,angle(H_0))
set(gca,'XTick',-2*pi:pi:2*pi)
set(gca,'XTickLabel',{'-2\pi','-\pi','0','\pi','2\pi'})
title('Phase Part of Bode Plots for θ = 0'); 
xlabel('w');
ylabel('∠H(e^j^w)');

subplot(3,3,4)
stem(n,h_5)
title('Impulse Response When θ = 0.5pi'); 
xlabel('n');
ylabel('h[n]');

subplot(3,3,5)
plot(w,20*log10(H_5))
set(gca,'XTick',-2*pi:pi:2*pi)
set(gca,'XTickLabel',{'-2\pi','-\pi','0','\pi','2\pi'})
title('Bode Plots for θ = 0.5pi'); 
xlabel('w');
ylabel('20log|H(e^j^w)|');

subplot(3,3,6)
plot(w,angle(H_5))
set(gca,'XTick',-2*pi:pi:2*pi)
set(gca,'XTickLabel',{'-2\pi','-\pi','0','\pi','2\pi'})
title('Phase Part of Bode Plots for θ = 0.5pi'); 
xlabel('w');
ylabel('∠H(e^j^w)');

subplot(3,3,7)
stem(n,h_pi)
title('Impulse Response When θ = pi'); 
xlabel('n');
ylabel('h[n]');

subplot(3,3,8)
plot(w,20*log10(H_pi))
set(gca,'XTick',-2*pi:pi:2*pi)
set(gca,'XTickLabel',{'-2\pi','-\pi','0','\pi','2\pi'})
title('Bode Plots for θ = pi'); 
xlabel('w');
ylabel('20log|H(e^j^w)|');

subplot(3,3,9)
plot(w,angle(H_pi))
set(gca,'XTick',-2*pi:pi:2*pi)
set(gca,'XTickLabel',{'-2\pi','-\pi','0','\pi','2\pi'})
title('Phase Part of Bode Plots for θ = pi'); 
xlabel('w');
ylabel('∠H(e^j^w)');
