function [tau] = att( q,qf,myrobot )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
l1 = myrobot.link{1};
l2 = myrobot.link{2};
l3 = myrobot.link{3};
l4 = myrobot.link{4};
l5 = myrobot.link{5};
l6 = myrobot.link{6};

H1c = getA(q(1), l1.alpha, l1.D, l1.A);
H2 = getA(q(2), l2.alpha, l2.D, l2.A);
H3 = getA(q(3), l3.alpha, l3.D, l3.A);
H4 = getA(q(4), l4.alpha, l4.D, l4.A);
H5 = getA(q(5), l5.alpha, l5.D, l5.A);
H6 = getA(q(6), l6.alpha, l6.D, l6.A);

H2c = H1c*H2;
H3c = H1c*H2*H3;
H4c = H1c*H2*H3*H4;
H5c = H1c*H2*H3*H4*H5;
H6c = H1c*H2*H3*H4*H5*H6;

%find Oi for every link
O1c = H1c(1:3,4);
O2c = H2c(1:3,4);
O3c = H3c(1:3,4);
O4c = H4c(1:3,4);
O5c = H5c(1:3,4);
O6c = H6c(1:3,4);

H1f = getA(qf(1), l1.alpha, l1.D, l1.A);
H2 = getA(qf(2), l2.alpha, l2.D, l2.A);
H3 = getA(qf(3), l3.alpha, l3.D, l3.A);
H4 = getA(qf(4), l4.alpha, l4.D, l4.A);
H5 = getA(qf(5), l5.alpha, l5.D, l5.A);
H6 = getA(qf(6), l6.alpha, l6.D, l6.A);

H2f = H1f*H2;
H3f = H1f*H2*H3;
H4f = H1f*H2*H3*H4;
H5f = H1f*H2*H3*H4*H5;
H6f = H1f*H2*H3*H4*H5*H6;

%find Oi final for every link
O1f = H1f(1:3,4);
O2f = H2f(1:3,4);
O3f = H3f(1:3,4);
O4f = H4f(1:3,4);
O5f = H5f(1:3,4);
O6f = H6f(1:3,4);

%calculate F attractive
Fatt1 = (O1f - O1c)*0.01;
Fatt2 = (O2f - O2c)*0.01;
Fatt3 = (O3f - O3c)*0.01;
Fatt4 = (O4f - O4c)*0.01;
Fatt5 = (O5f - O5c)*0.01;
Fatt6 = (O6f - O6c)*0.01;

Fatt = [Fatt1 Fatt2 Fatt3 Fatt4 Fatt5 Fatt6];

%Find Jacobian
Jv11 = cross([0; 0; 1;], O1c);

Jv21 = cross([0; 0; 1;], O2c);
Jv22 = cross(H1c(1:3, 3), (O2c-O1c));

Jv31 = cross([0; 0; 1;], O3c);
Jv32 = cross(H1c(1:3, 3), (O3c-O1c));
Jv33 = cross(H2c(1:3, 3), (O3c-O2c));

Jv41 = cross([0; 0; 1;], O4c);
Jv42 = cross(H1c(1:3, 3), (O4c-O1c));
Jv43 = cross(H2c(1:3, 3), (O4c-O2c));
Jv44 = cross(H3c(1:3, 3), (O4c-O3c));

Jv51 = cross([0; 0; 1;], O5c);
Jv52 = cross(H1c(1:3, 3), (O5c-O1c));
Jv53 = cross(H2c(1:3, 3), (O5c-O2c));
Jv54 = cross(H3c(1:3, 3), (O5c-O3c));
Jv55 = cross(H4c(1:3, 3), (O5c-O4c));

Jv61 = cross([0; 0; 1;], O6c);
Jv62 = cross(H1c(1:3, 3), (O6c-O1c));
Jv63 = cross(H2c(1:3, 3), (O6c-O2c));
Jv64 = cross(H3c(1:3, 3), (O6c-O3c));
Jv65 = cross(H4c(1:3, 3), (O6c-O4c));
Jv66 = cross(H5c(1:3, 3), (O6c-O5c));

z3 = zeros(3,1);
Jo1 = [Jv11 z3 z3 z3 z3 z3];
Jo2 = [Jv21 Jv22 z3 z3 z3 z3];
Jo3 = [Jv31 Jv32 Jv33 z3 z3 z3];
Jo4 = [Jv41 Jv42 Jv43 Jv44 z3 z3];
Jo5 = [Jv51 Jv52 Jv53 Jv54 Jv55 z3];
Jo6 = [Jv61 Jv62 Jv63 Jv64 Jv65 Jv66];

%retreive final tau for attractive force
tau = ((Jo1)'*Fatt1) + ((Jo2)'*Fatt2) + ((Jo3)'*Fatt3) + ((Jo4)'*Fatt4) + ((Jo5)'*Fatt5) + ((Jo6)'*Fatt6);

tau = tau/norm(tau);
tau = tau';
end

