n = -5: 5;
y = [];
for i = n
    if i >= -2 && i <= 2
        temp = i;
        y = [y, temp];
    else
        y = [y, 0];
    end
end
stem([-10: 10], conv(y, y));