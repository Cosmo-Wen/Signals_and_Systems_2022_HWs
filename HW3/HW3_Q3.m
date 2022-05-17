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
