clc;    clear;
%%
%     不知道
%     108060002  周廷紘
%     109060035  温柏崴
%     109060044  莊凱威

%% Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1

n = 0: 200;

z1 = exp((1/20)*2*pi*1i*n);         % fundemental frequency of 20
z2 = exp((1/30)*2*pi*1i*n);         % fundemental frequency of 30
z3 = exp((1/60)*2*pi*1i*n);         % fundemental frequency of 60

figure();                           % figure 1
stem(n, real(z1), 'o');
hold on;
stem(n, real(z2), 'x');
stem(n, real(z3), '*');
hold off;

figure();                           % figure 2
stem(n, real(z1 + z2 + z3), 'h');   % fundemental frequency of N

% N = gcd(20, 30, 60), or the first place where z1, z2, z3 intersects
% same as the conclusion drawn from page 22 of the slides

%% Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2


clc; clear;

x = -10 : 10;
y = 0;

for k = -2 : 2
    n = k.*(k <= 2 && k >= -2);                 % Determine the original graph
    nshiftk = circshift(x, k);                  % move the graph n by k
    nk = k.*(nshiftk >= -2 & nshiftk <= 2);     % Doing the convolution (the amp part)
    y = y + nshiftk.*nk;                        % Doing the convolution (adding part)
end

stem(x, y);

% you don't have to reverse the second function if the values are evaluated from left to right


%% Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3Q3


clc, clear;

t = linspace(-2, 12);
y = zeros(length(t));
for li = 1 : length(t)
    fun = @(x) x.*(t(li)-x).^3;                     % f(x) * g(x) = integral(f(t)g(x-t))dx from -inf to inf, fun = f(x)g(t-x)
    if t(li) <= -1                                  % t + 1 <= 0, t <= -1
        y(li) = 0;                                  % no overlap
    elseif t(li) <= 2                               % t + 1 >= 0 and t - 2 <= 0, -1 <= t <= 2
        y(li) = integral(fun, 0, t(li)+1);          % overlap, integrate fun from 0 to t + 1
    elseif t(li) <= 3                               % t - 2 >= 0 and t + 1 <= 4, 2 <= t <= 3
        y(li) = integral(fun, t(li)-2, t(li)+1);    % overlap, integrate fun from t - 2 to t + 1
    elseif t(li) <= 6                               % t - 2 <= 4, t <= 6
        y(li) = integral(fun, t(li)-2, 4);          % overlap, intergate fun from t - 2 to 4
    else                                            % t - 2 >= 4, t >= 6
        y(li) = 0;                                  % no overlap
    end
end

plot(t, y);