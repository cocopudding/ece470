function [ q ] = inverse_kuka( myrobot, H )
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
Oc = Od - Rd * [l6.A; 0; l6.D];
xc = Oc(1);
yc = Oc(2);
zc = Oc(3);

% find theta1
q(1) = atan2(yc, xc);

% find theta3
bc = real(sqrt(l3.A^2 + l4.D^2));
ac = real(sqrt((zc-l1.D)^2 + (real(sqrt(xc^2 + yc^2)) - l1.A)^2));
phi=acos((bc^2 + l2.A^2 - ac^2)/(2*bc*l2.A));
rho = atan(l4.D/l3.A);
q(3) = phi + rho - pi;

% find theta2
cr = zc - l1.D;
ar = sqrt(xc^2 + yc^2) - l1.A;
gamma = atan(cr/ar);
bc = sqrt(l3.A^2 + l4.D^2);
ab = l2.A;
ac = sqrt(ar^2 + cr^2);
phi = acos((ac^2 + ab^2 - bc^2) / (2 * ac * ab));
q(2) = gamma + phi;
 
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

