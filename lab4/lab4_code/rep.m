function [ tau ] = rep( q,myrobot,obs)
%UNTITLED5 Summary of this function goes here
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

if strcmp(obs.type,'cyl')
    [rho1, rho_g1] = rho_lab4( obs.R, obs.c, obs.h, O1c);
    [rho2, rho_g2] = rho_lab4( obs.R, obs.c, obs.h, O2c);
    [rho3, rho_g3] = rho_lab4( obs.R, obs.c, obs.h, O3c);
    [rho4, rho_g4] = rho_lab4( obs.R, obs.c, obs.h, O4c);
    [rho5, rho_g5] = rho_lab4( obs.R, obs.c, obs.h, O5c);
    [rho6, rho_g6] = rho_lab4( obs.R, obs.c, obs.h, O6c);

else
    [rho1, rho_g1] = rho_xy_plane(O1c);
    [rho2, rho_g2] = rho_xy_plane(O2c);
    [rho3, rho_g3] = rho_xy_plane(O3c);
    [rho4, rho_g4] = rho_xy_plane(O4c);
    [rho5, rho_g5] = rho_xy_plane(O5c);
    [rho6, rho_g6] = rho_xy_plane(O6c);
end
%find rho i and rho i gradient acorrding to obs type


n = 1;
%find F repulsive. If rho i > rho 0, F repulsive = 0
if rho1 > obs.rho0
    Frep1 = [0;0;0];
else
    Frep1 = (1/rho1 - 1/(obs.rho0))* (1/(rho1^2)) * rho_g1 * n; 
end

if rho2 > obs.rho0
    Frep2 = [0;0;0];
else
    Frep2 = (1/rho2 - 1/(obs.rho0))* (1/(rho2^2)) * rho_g2 * n; 
end

if rho3 > obs.rho0
    Frep3 = [0;0;0];
else
    Frep3 = (1/rho3 - 1/(obs.rho0))* (1/(rho3^2)) * rho_g3 * n; 
end

if rho4 > obs.rho0
    Frep4 = [0;0;0];
else
    Frep4 = (1/rho4 - 1/(obs.rho0))* (1/(rho4^2)) * rho_g4 * n;
end

if rho5 > obs.rho0
    Frep5 = [0;0;0];
else
    Frep5 = (1/rho5 - 1/(obs.rho0))* (1/(rho5^2)) * rho_g5 * n;
end

if rho6 > obs.rho0
    Frep6 = [0;0;0];
else
    Frep6 = (1/rho6 - 1/(obs.rho0))* (1/(rho6^2)) * rho_g6 * n;
end

Frep = [Frep1 Frep2 Frep3 Frep4 Frep5 Frep6];

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

%retreive final tau for repulsive force
tau = ((Jo1)'*Frep1) + ((Jo2)'*Frep2) + ((Jo3)'*Frep3) + ((Jo4)'*Frep4) + ((Jo5)'*Frep5) + ((Jo6)'*Frep6);

%prevent division by 0 error
if norm(tau) == 0
    tau = tau';
else
    tau = tau/norm(tau);
    tau = tau';
end

end

