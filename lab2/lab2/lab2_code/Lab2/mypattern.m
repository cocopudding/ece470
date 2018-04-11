function [ X ] = mypattern()
X = zeros(3, 100)
origin = [620 0 -9.72];
theta = linspace(0, 2*pi, 100);
for i = 1 : 100
    r = 2 - 2 * sin(theta(i)) + sin(theta(i))* (sqrt(abs(cos(theta(i))))) / (sin(theta(i)) + 1.4)
    r = 40 * r;
    X(1,i) = origin(1) + r * cos(theta(i));
    X(2,i) = origin(2) + r * sin(theta(i));
    X(3,i) = -9.72;
end

