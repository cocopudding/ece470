function [ rho_xy_plane, rho_xy_plane_gradient ] = rho_xy_plane(O)
Ox = O(1);
Oy = O(2);
Oz = O(3);

b_xy = [Ox; Oy; 0];

rho_xy_plane = Oz;
rho_xy_plane_gradient = (O-b_xy)/Oz;

end
