function [ rho_lab4, rho_lab4_gradient ] = rho_lab4( R, c, h, O )
%RHO_CYLINER Summary of this function goes here
%   Detailed explanation goes here
Ox = O(1);
Oy = O(2);
Oz = O(3);

Cx = c(1);
Cy = c(2);

if Oz <= h
    Cz = Oz;
else
    Cz = h;
end

b_den = sqrt((Ox-Cx)^2 + (Oy-Cy)^2);
b = [R*(Ox-Cx)/b_den + Cx; R*(Oy-Cy)/b_den + Cy; Cz];
rho_cylinder = norm(O-b);
rho_cylinder_gradient = (O-b)/norm(O-b);

b_xy = [Ox; Oy; 0];

rho_xy_plane = Oz;
rho_xy_plane_gradient = (O-b_xy)/Oz;

% if rho_cylinder < rho_xy_plane
%     rho_final = rho_cylinder;
%     rho_final_gradient = rho_cylinder_gradient;
% else
%     rho_final = rho_xy_plane;
%     rho_final_gradient = rho_xy_plane_gradient;
% end

rho_lab4 = rho_cylinder;
rho_lab4_gradient = rho_cylinder_gradient;

end
