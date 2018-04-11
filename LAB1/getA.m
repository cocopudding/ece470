function [ A ] = getA( theta, alpha, di, ai )
% Calculate the transformation matrix of each link given row from 
% DH table
A = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha)  ai*cos(theta);
     sin(theta) cos(theta)*cos(alpha)  -cos(theta)*sin(alpha) ai*sin(theta);
     0          sin(alpha)             cos(alpha)             di;
     0          0                      0                      1];
end

