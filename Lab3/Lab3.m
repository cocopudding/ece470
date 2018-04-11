%% 4.1
% DH Table
DH = [pi/2 0 0 76;
      0 43.23 0 -23.65;
      pi/2 0 0 0;
      -pi/2 0 0 43.18;
      pi/2 0 0 0;
      0 0 0 20];
myrobot = mypuma560(DH);

H1 = eul2tr([0 pi pi/2]);
H1(1:3,4) = 100*[-1;3;3;]/4;
q1 = inverse(H1,myrobot);
H2 = eul2tr([0 pi -pi/2]);
H2(1:3,4) = 100*[3;-1;2;]/4;
q2 = inverse(H2,myrobot);
tau_att = att( q1,q2,myrobot )

%% 4.2
q2(4) = q2(4) + 2*pi;
qref = motionplan_without_rep(q1,q2,0,10,myrobot,[],0.01);
t = linspace(0,10,300);
q = ppval(qref,t)';
plot(myrobot,q)

%% 4.3
H1 = eul2tr([0 pi pi/2]);
H1(1:3,4) = 100*[-1;3;3;]/4;
q1 = inverse(H1,myrobot);
H2 = eul2tr([0 pi -pi/2]);
H2(1:3,4) = 100*[3;-1;2;]/4;
q2 = inverse(H2,myrobot);

q2(4) = q2(4) + 2*pi;
setupobstacle
q3 = 0.9*q1+0.1*q2;
tau_cylinder1_rep = rep(q3,myrobot,obs{1})

q = [pi/2 pi 1.2*pi 0 0 0];
q(4) = q(4) + 2*pi;
tau_sphere6_rep = rep(q,myrobot,obs{6})

%%  4.3 with motion plan (please run section and do not do full run to show this part)
clear all;
DH = [pi/2 0 0 76;
      0 43.23 0 -23.65;
      pi/2 0 0 0;
      -pi/2 0 0 43.18;
      pi/2 0 0 0;
      0 0 0 20];
myrobot = mypuma560(DH);
H1 = eul2tr([0 pi pi/2]);
H1(1:3,4) = 100*[-1;3;3;]/4;
q1 = inverse(H1,myrobot);
H2 = eul2tr([0 pi -pi/2]);
H2(1:3,4) = 100*[3;-1;2;]/4;
q2 = inverse(H2,myrobot);

setupobstacle
hold on
axis([-100 100 -100 100 0 200])
view(-32,50)
plotobstacle(obs);
q2(4) = q2(4) + 2*pi;
qref = motionplan_with_rep(q1,q2,0,10,myrobot,obs{2},0.01);
t=linspace(0,10,300);
q=ppval(qref,t)';
plot(myrobot,q);

hold off