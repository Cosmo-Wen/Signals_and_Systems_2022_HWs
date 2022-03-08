clc;    clear;
%%
%     不知道
%     108060002  周廷紘
%     109060035  温柏崴
%     109060044  莊凱威

%% Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1

clc; clear; 
n = linspace(0, 10*pi, 200);
z1 = exp((1/2)*pi*1i*n); 
z2 = exp((2/3)*pi*1i*n); 
z3 = exp((5/6)*pi*1i*n); 
figure();
stem(n, real(z1), 'o');
hold on;
stem(n, real(z2), 'x');
stem(n, real(z3), '*');
axis([0 20 -3 3]);
hold off;
figure();
stem(n, real(z1 + z2 + z3), 'h');
axis([0 20 -3 3]);

%% Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2

% using matlab function

clc; clear;
x = -10 : 10;
y = 0;

for k = -2 : 2
    nshiftk = circshift(x, k);
    nk = k.*(nshiftk >= -2 & nshiftk <= 2);
    y = y + nshiftk.*nk;
end

stem(x, y);

% using formula


%% Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3

% using matlab function

clc, clear;
t = linspace(-2, 12);
y = zeros(length(t));
for li = 1 : length(t)
    fun = @(x) x.*(t(li)-x).^3;
    if t(li) < -1
        y(li) = 0;
    elseif t(li) < 2
        y(li) = integral(fun, 0, t(li)+1);
    elseif t(li) < 3
        y(li) = integral(fun, t(li)-2, t(li)+1);
    elseif t(li) < 6
        y(li) = integral(fun, t(li)-2, 4);
    else
        y(li) = 0;
    end
end
plot(t, y);

% using formula










