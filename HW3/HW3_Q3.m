clc;    clear;

Fs = 50000;
t = 0: 1 / Fs: 0.1 - 1 / Fs;
df = Fs / length(t);
w = (-Fs / 2: df: Fs / 2 - df) * 2 * pi;

% y''(t) + 2ζω0 y'(t) + ω0^2 y(t) = ω0^2 x(t)
% (-ω^2 + 2ζω0(jω) + ω0^2) Y(jω) = ω0^2 X(jω)
% H(jω) = (ω0^2) / (-ω^2 + 2ζω0(jω) + ω0^2)

wn = 100;
z1 = 0.5;
z2 = 1;
z3 = 1.5;
H1 = wn^2 ./ (-w.^2 + 2 * z1 * wn * 1i * w + wn^2);
H2 = wn^2 ./ (-w.^2 + 2 * z2 * wn * 1i * w + wn^2);
H3 = wn^2 ./ (-w.^2 + 2 * z3 * wn * 1i * w + wn^2);

h1 = ifft(ifftshift(H1));
h2 = ifft(ifftshift(H2));
h3 = ifft(ifftshift(H3));

subplot(3, 3, 1);
plot(t, h1);
subplot(3, 3, 2);
semilogx(w, 20 * log(abs(H1)))
subplot(3, 3, 3);
semilogx(w, angle(H1))
subplot(3, 3, 4);
plot(t, h2);
subplot(3, 3, 5);
semilogx(w, 20 * log(abs(H2)))
subplot(3, 3, 6);
semilogx(w, angle(H2))
subplot(3, 3, 7);
plot(t, h3);
subplot(3, 3, 8);
semilogx(w, 20 * log(abs(H3)))
subplot(3, 3, 9);
semilogx(w, angle(H3))