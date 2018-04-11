
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

setupobstacle_lab4prep;
tau = rep([pi/10,pi/12,pi/6,pi/2,pi/2,-pi/6],kuka_forces,prepobs{1})

%% Motion Planner
p1 = [620 375 50];
p2 = [620 -375 50];
R = [0 0 1;0 -1 0;1 0 0];
H1 = [R p1';zeros(1, 3) 1];
H1
H2 = [R p2';zeros(1, 3) 1];
H2
q1 = inverse_kuka(kuka, H1);
q1
q2 = inverse_kuka(kuka, H2);
q2

hold on
axis([-800 800 -800 800 0 1000])
view(-20,30)
plotobstacle(prepobs);
qref = motionplan_with_rep(q1, q2, 0, 10, kuka_forces, prepobs{1}, prepobs{2},0.015);
t=linspace(0,10,300);
q=ppval(qref,t)';
plot(kuka,q);











