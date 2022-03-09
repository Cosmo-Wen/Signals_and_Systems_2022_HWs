t = 0:0.00005:1;
tl = linspace(0, 2, 40001);
delta = [];
y = exp(-2 * t);

for i = t                           % delta function of 1000 * 1/1000
    if i < 1 / 1000
        delta = [delta, 1000];
    else
        delta = [delta, 0];
    end
end

plot(t, y);
hold on
plot(tl, conv(y, delta) / 20000);   % discrete convolution with adjustment to dt