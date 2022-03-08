x = -10 : 10;
y = 0;

for k = -2 : 2
    n = k.*(k <= 2 && k >= -2);
    nshiftk = circshift(x, k);
    nk = k.*(nshiftk >= -2 & nshiftk <= 2);
    y = y + nshiftk.*nk;
end

stem(x, y);