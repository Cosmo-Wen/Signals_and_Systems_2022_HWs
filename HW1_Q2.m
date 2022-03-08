x = -10 : 10;
y = 0;

for k = -2 : 2
    n = k.*(k <= 2 && k >= -2);                 % Determine the original graph
    nshiftk = circshift(x, k);                  % move the graph n by k
    nk = k.*(nshiftk >= -2 & nshiftk <= 2);     % Doing the convolution (the amp part)
    y = y + nshiftk.*nk;                        % Doing the convolution (adding part)
end

stem(x, y);