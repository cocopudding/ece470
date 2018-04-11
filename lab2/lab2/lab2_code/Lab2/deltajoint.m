function [ X_error ] = deltajoint( delta )
kuka = mykuka_search(delta);
o = [620 0 -4.72]';
Q1 = [0.0730 0.6023 0 0.0508 0.9912 0]; %point1
X1 = [55 37 0]' + o;
H1 = forward_kuka(kuka, Q1);
Q2 = [-0.0339 0.6023 0 0.0508 0.9912 0]; %point2
X2 = [54 -33 0]' + o;
H2 = forward_kuka(kuka, Q2);
Q3 = [0.1346 0.7386 -0.2288 0.0508 0.9912 0]; %point3
X3 = [-28 7 0]' + o;
H3 = forward_kuka(kuka, Q3);
X_error = norm(H1(1:3,4)-X1)+norm(H2(1:3,4)-X2)+norm(H3(1:3,4)-X3);
end

