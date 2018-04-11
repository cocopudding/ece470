clear
clc
%% 4.1 
% DH Table
DH = [pi/2 0 0 76;
      0 43.23 0 -23.65;
      pi/2 0 0 0;
      -pi/2 0 0 43.18;
      pi/2 0 0 0;
      0 0 0 20];
myrobot = mypuma560(DH);

%% 4.2
% generate q, the joint space trajectory
q = [linspace(0, pi, 200);
     linspace(0, pi/2, 200);
     linspace(0, pi, 200);
     linspace(pi/4, 3*pi/4, 200);
     linspace(-pi/3, pi/3, 200);
     linspace(0, 2*pi, 200)];
q = q';
plot(myrobot, q)

%% 4.3
% generate o, coordinates of the end effector
o = zeros(200, 3);
for i = 1:200
   joint_angles = q(i,:); 
   H = forward(joint_angles, myrobot);
   o(i,:) = transpose(H(1:3,4));
end
plot3(o(:,1), o(:,2), o(:,3), 'r')
hold on
plot(myrobot,q)

%% 4.4
% generate d, which is 100 points along the line connecting (10, 23, 15)
% (30, 30, 100)
d = zeros(3, 100);
d(1,:) = linspace(10, 30, 100);  % x axis
d(2,:) = linspace(23, 30, 100);  % y axis
d(3,:) = linspace(15, 100, 100); % z axis
d = d';                          % d should be 100 x 3

% Rz, pi/4
R = [cos(pi/4) -sin(pi/4) 0;
     sin(pi/4) cos(pi/4)  0;
     0         0          1];

 % test
 q = inverse([cos(pi/4) -sin(pi/4) 0 20;
              sin(pi/4) cos(pi/4)  0 23;
              0         0          1 15;
              0         0          0 1], myrobot)
 
 Q = zeros(100, 6);
 
 % generate Q the joint angles for tracking the trajectory
 for i = 1:100
     coor = d(i,:);
     tempH = [R,[coor(1); coor(2); coor(3)]; 0 0 0 1];
     Q(i, :) = inverse(tempH, myrobot);
 end
 clf;
 plot3(d(:, 1), d(:, 2), d(:, 3), 'r');
 hold on;
 plot(myrobot, Q);
