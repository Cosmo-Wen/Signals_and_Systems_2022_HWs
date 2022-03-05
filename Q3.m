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