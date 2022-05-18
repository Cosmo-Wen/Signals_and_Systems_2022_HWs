clc;    clear;

% Sampling Frequency
Fs = 5000;

% Δω = 2π * 10^9
dw = 2 * pi * 10^9;

% Set time and frequency scale
t = -5: 1 / Fs: 5;
df = Fs / length(t);
freq = (-Fs / 2: df: Fs / 2 - df) * 2 * pi;

% β = 2π
b1 = 2 * pi;

% Construct e1 and its Fourier Transform
e1 = exp(1i * b1 * sin(dw * t));
E1 = fftshift(fft(fftshift(e1))) / Fs;

% β = 4π
b2 = 4 * pi;

% Construct e2 and its Fourier Transform
e2 = exp(1i * b2 * sin(dw * t));
E2 = fftshift(fft(fftshift(e2))) / Fs;

% E3 = Magnitude of E1 and Phase of 1
E3 = abs(E1);
e3 = ifftshift(ifft(ifftshift(E3 * Fs)));

%  E4 = Magnitude of E2 and Phase of 1
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