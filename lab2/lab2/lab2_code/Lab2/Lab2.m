clc

 %% Lab2 Prep 
% DH Table
delta = [9.0009 -12.9852];
DH = [pi/2  25      0  400;
      0     315     0  0;
      pi/2  35      0  0;
      -pi/2 0       0  365;
      pi/2  0       0  0;
      0     -296.23-delta(1)  0  161.44+delta(2)];
kuka = mykuka(DH);
% The forward kinematics 
H = forward_kuka(kuka, [pi/5 pi/3 -pi/4 pi/4 pi/3 pi/4]')

% The inverse kinematics
%joint_angles = inverse_kuka(kuka, H)

% Lab2 in lab inverse
H = [0 0 1 620;
     0 -1 0 0;
     1 0 0 -4.72;
     0 0 0 1];
joint_angles = inverse_kuka(kuka, H) 
%%
% Draw line
H = [0 0 1 620;
     0 -1 0 0;
     1 0 0 -4.72;
     0 0 0 1];
X = mysegment();
for i = 1 : 100
    i
    H(1:3,4)= X(:,i);
    joint_angles = inverse_kuka(kuka, H)
    setAngles(joint_angles, 0.01)
end

%%
% Draw Circle
H = [0 0 1 620;
     0 -1 0 0;
     1 0 0 -4.72;
     0 0 0 1];
X = mycircle();
for i = 1 : 100
    i
    H(1:3,4)= X(:,i);
    joint_angles = inverse_kuka(kuka, H)
    setAngles(joint_angles, 0.02)
end

%%
% Draw Heart
H = [0 0 1 620;
     0 -1 0 0;
     1 0 0 -4.72;
     0 0 0 1];
X = mypattern();
for i = 1 : 100
    i
    H(1:3,4)= X(:,i);
    joint_angles = inverse_kuka(kuka, H)
    setAngles(joint_angles, 0.02)
end
