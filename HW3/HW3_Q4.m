clc;    clear;

dw = 2*pi*10^-3;

n = 0:1:49;
w = -2*pi:dw:2*pi;

h_0 = (n+1).*0.5.^n .* (n>=0);
h_25 = 0.5.^n.*(sin((n+1)*0.25*pi)/sin(0.25*pi)) .* (n>=0);
h_pi = (n+1).*(-0.5).^n .* (n>=0);

H_0 = 1./(1-2*0.5*cos(0).*exp(-1j.*w)+0.5^2.*exp(-2j.*w));
H_25 = 1./(1-2*0.5*cos(0.25*pi).*exp(-1j.*w)+0.5^2.*exp(-2j.*w));
H_pi = 1./(1-2*0.5*cos(pi).*exp(-1j.*w)+0.5^2.*exp(-2j.*w));

subplot(3,2,1)
stem(n,h_0)

subplot(3,2,2)
plot(w,20*log10(H_0))
set(gca,'XTick',-2*pi:pi:2*pi)
set(gca,'XTickLabel',{'-2\pi','-\pi','0','\pi','2\pi'})

subplot(3,2,3)
stem(n,h_25)

subplot(3,2,4)
plot(w,20*log10(H_25))
set(gca,'XTick',-2*pi:pi:2*pi)
set(gca,'XTickLabel',{'-2\pi','-\pi','0','\pi','2\pi'})

subplot(3,2,5)
stem(n,h_pi)

subplot(3,2,6)
plot(w,20*log10(H_pi))
set(gca,'XTick',-2*pi:pi:2*pi)
set(gca,'XTickLabel',{'-2\pi','-\pi','0','\pi','2\pi'})



