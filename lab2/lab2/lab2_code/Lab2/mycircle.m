function [ X ] = mycircle()
X = zeros(3, 100)
origin = [620 0 -9.72];
theta = linspace(0, 2*pi, 100);
for i = 1 : 100
    X(1,i) = origin(1) + 50 * cos(theta(i));
    X(2,i) = origin(2) + 50 * sin(theta(i));
    X(3,i) = -9.72;
end


