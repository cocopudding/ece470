function [ H ] = forward( joint, myrobot )
% Implement the forward kinemetic sovler given joint angle and
% robot definition
l1 = myrobot.link{1};
l2 = myrobot.link{2};
l3 = myrobot.link{3};
l4 = myrobot.link{4};
l5 = myrobot.link{5};
l6 = myrobot.link{6};
H1 = getA(joint(1), l1.alpha, l1.D, l1.A);
H2 = getA(joint(2), l2.alpha, l2.D, l2.A);
H3 = getA(joint(3), l3.alpha, l3.D, l3.A);
H4 = getA(joint(4), l4.alpha, l4.D, l4.A);
H5 = getA(joint(5), l5.alpha, l5.D, l5.A);
H6 = getA(joint(6), l6.alpha, l6.D, l6.A);
H = H1*H2*H3*H4*H5*H6;
end

