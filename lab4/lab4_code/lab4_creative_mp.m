%% Test Simple 2D path planning
o_i = [0; 0];
o_f = [4; 0];
obs1.R = 1;
obs1.c = [1.1; 0.2];
myrobot = {};

qref = grid_search_mp(o_i, o_f, 0, 10, myrobot, obs1, 0.05, 0.07);
x = zeros(1, length(qref));
y = zeros(1, length(qref));

for i = 1 : length(qref)
    t = qref(i);
    x(i) = t{1}(1,1);
    y(i) = t{1}(2,1);
end 

plot(x, y, 'o')

%% Test with Kuka
delta = [0 0];
a6_delta = 156; %-296.23
DH = [pi/2  25       0  400;
      0     315      0  0;
      pi/2  35       0  0;
      -pi/2 0        0  365;
      pi/2  0        0  0;
      0     -a6_delta 0  161.44+delta(2)];

% Define Robot
kuka = mykuka(DH);

% Init param
p1 = [620 375 50];
p2 = [620 -375 50];
R = [0 0 1;0 -1 0;1 0 0];
prepobs{1}.R = 100;
prepobs{1}.c = [620; 0];
prepobs{1}.rho0 = 150;
prepobs{1}.h = 572;
prepobs{1}.type = 'cyl';

% Plot Obs
hold on
axis([-800 800 -800 800 0 1000])
view(-20,30)
plotobstacle(prepobs);
o_i = [p1(1); p1(2)];
o_f = [p2(1); p2(2)];

% Plan
t1 = 0;
t2 = 10;
z_o = p1(3);
xy_waypoints = grid_search_mp(o_i, o_f, t1, t2, kuka, prepobs{1}, 0.1, 0.2);
t= linspace(t1, t2, length(xy_waypoints));
temp = xy_waypoints(1);
origin = [temp{1}(1,1) temp{1}(2,1) 50];
H = [R origin'; zeros(1, 3) 1];
q = inverse_kuka(kuka, H);

for i = 2 : length(xy_waypoints)
    temp = xy_waypoints(i);
    origin = [temp{1}(1,1) temp{1}(2,1) 50];
    H = [R origin'; zeros(1, 3) 1];
    joint_angles = inverse_kuka(kuka, H);
    q = vertcat(q, joint_angles);
end
% Spline interpolation
qref = spline(t, q');
q_final=ppval(qref,t)';
plot(kuka,q_final);
