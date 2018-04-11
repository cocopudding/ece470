function [ X ] = mysegment()
X = zeros(3, 100)
y_coor = linspace(-100, 100, 100);
for i = 1 : length(y_coor)
    X(1,i) = 620;
    X(2,i) = y_coor(i);
    X(3,i) = -9.72;
end


