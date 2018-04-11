function [ q ] = inverse( H, myrobot )
% Inverse kinematic solver given desired orientation and location and
% Robot definition

% links
q = zeros(1, 6);
l1 = myrobot.link{1};
l2 = myrobot.link{2};
l3 = myrobot.link{3};
l4 = myrobot.link{4};
l6 = myrobot.link{6};

% calculation
Rd = H(1:3, 1:3);
Od = H(1:3, 4);
Oc = Od - Rd * [0; 0; l6.D];
xc = Oc(1);
yc = Oc(2);
zc = Oc(3);

% find theta1
q(1) = atan2(yc, xc) - atan2(-1*l2.D, real(sqrt(xc^2 + yc^2 - l2.D^2)));

% find theta3
D = (xc^2 + yc^2 - l2.D^2 + (zc - l1.D)^2 - l2.A^2 - l4.D^2) / (2 * l2.A * l4.D);
q(3) = atan2(D, real(sqrt(1 - D^2)));

% find theta2
q(2) = atan2(zc - l1.D, real(sqrt(xc^2 + yc^2 - l2.D^2))) ...
       - atan2(-l4.D * cos(q(3)), l2.A + l4.D * sin(q(3)));

% find theta 4, 5, 6
H1 = getA(q(1), l1.alpha, l1.D, l1.A);
H2 = getA(q(2), l2.alpha, l2.D, l2.A);
H3 = getA(q(3), l3.alpha, l3.D, l3.A);
H03 = H1 * H2 * H3;
R03 = H03(1:3, 1:3);
A = R03' * Rd;

% find theta 4
q(4) = atan2(A(2, 3), A(1, 3));
q(5) = atan2(real(sqrt(1 - A(3, 3)^2)), A(3, 3));
q(6) = atan2(A(3, 2), -A(3, 1));
end

