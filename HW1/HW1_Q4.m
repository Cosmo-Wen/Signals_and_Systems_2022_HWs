t = linspace(0, 5, 100);
tl = linspace(0, 5, 199);
delta = [];
h = [];
for i = t
    if i < 0
        delta = [delta, 0];
    elseif i <= 1/10
        delta = [delta, 10*i];
    else
        delta = [delta, 0];
    end
end
for i = t
    if i < 0
        h = [h, 0];
    else
        h = [h, exp(-2*i)];
    end
end
y = conv(delta, h);
plot(t, h);
hold on
plot(tl, y);
        
