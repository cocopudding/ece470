
%% lab4 prep
% DH Table
%delta = [9.0009 -12.9852];
delta = [0 0];
a6_delta = 156; %-296.23

DH = [pi/2  25       0  400;
      0     315      0  0;
      pi/2  35       0  0;
      -pi/2 0        0  365;
      pi/2  0        0  0;
      0     -a6_delta 0  161.44+delta(2)];
kuka = mykuka(DH);

DH_forces = [pi/2   25    0  400;
             0      315   0  0;
             pi/2   35    0  0;
             -pi/2  0     0  365;
             pi/2   0     0  0;
             0      0     0  161.44+delta(2)];
kuka_forces = mykuka(DH_forces);

setupobstacle_inlab;

%% Motion Planner\
z_grid = 27;
p0 = [370 -440 150];
p05 = [370 -440 75];
p1 = [370 -440 z_grid];
p2 = [750 -220 225];
p3 = [620 350 225];

R = [0 0  1;
     0 -1 0;
     1 0  0];

H0 = [R p0';zeros(1, 3) 1];
H05 = [R p05';zeros(1, 3) 1];
H1 = [R p1';zeros(1, 3) 1];
H2 = [R p2';zeros(1, 3) 1];
H3 = [R p3';zeros(1, 3) 1];

q0 = inverse_kuka(kuka, H0);
q05 = inverse_kuka(kuka, H05);
q1 = inverse_kuka(kuka, H1);
q2 = inverse_kuka(kuka, H2);
q3 = inverse_kuka(kuka, H3);

hold on
axis([-800 800 -800 800 0 1000])
view(-20,30)
plotobstacle(prepobs);

setGripper(1) % Open Gripper
qref = motionplan_with_rep_4_2(q0, q05, 0, 10, kuka_forces, prepobs{1}, prepobs{2}, prepobs{3}, 0.015);
t=linspace(0,10,300);
q=ppval(qref,t)';
q6 = linspace(q0(6), q05(6), 300);

for i = 1 : 300
    joint_angles = q(i,:);
    joint_angles(6) = q6(i);
    setAngles(joint_angles, 0.01)
end

% for i = 1 : 300
%     joint_angles = q(i,:);
%     joint_angles(6) = q6(i);
%     q(i,:) = joint_angles;
% end
% plot(kuka,q);

qref = motionplan_with_rep_4_2(q05, q1, 0, 10, kuka_forces, prepobs{1}, prepobs{2}, prepobs{3}, 0.015);
t=linspace(0,10,300);
q=ppval(qref,t)';
q6 = linspace(q05(6), q1(6), 300);
for i = 1 : 300
    joint_angles = q(i,:);
    joint_angles(6) = q6(i);
    setAngles(joint_angles, 0.01)
end

% for i = 1 : 300
%     joint_angles = q(i,:);
%     joint_angles(6) = q6(i);
%     q(i,:) = joint_angles;
% end
% plot(kuka,q);

setGripper(0) % Close Gripper

qref = motionplan_with_rep_4_2(q1, q2, 10, 20, kuka_forces, prepobs{1}, prepobs{2}, prepobs{3}, 0.05);
t=linspace(10,20,300);
q=ppval(qref,t)';
q6 = linspace(q1(6), q2(6), 300);
for i = 1 : 300
    joint_angles = q(i,:);
    joint_angles(6) = q6(i);
    setAngles(joint_angles, 0.01)
end

% for i = 1 : 300
%     joint_angles = q(i,:);
%     joint_angles(6) = q6(i);
%     q(i,:) = joint_angles;
% end
% plot(kuka,q);

qref = motionplan_with_rep_4_2(q2, q3, 20, 30, kuka_forces, prepobs{1}, prepobs{2}, prepobs{3}, 0.05);
t=linspace(20,30,300);
q=ppval(qref,t)';
q6 = linspace(q2(6), q3(6), 300);
for i = 1 : 300
    joint_angles = q(i,:);
    joint_angles(6) = q6(i);
    setAngles(joint_angles, 0.01)
end

% for i = 1 : 300
%     joint_angles = q(i,:);
%     joint_angles(6) = q6(i);
%     q(i,:) = joint_angles;
% end
% plot(kuka,q);

setGripper(1) % Open Gripper
disp('Done')

