function [ waypoints ] = grid_search_mp(o_i, o_f, t1, t2, myrobot, obs1, step_size, accur) 
% This function utilize simple grid search. It implements A* search on a 2D
% plane. In this case, the assumption is this problem can be turned into 2D
% problem

x_i = o_i(1);
y_i = o_i(2);
x_f = o_f(1);
y_f = o_f(2);

% Bug search to generate an array of x,y setpoints
dist = real(sqrt((x_f - x_i)^2 + (y_f - y_i)^2));
waypoints = {};
waypoints = [waypoints, [x_i; y_i]];

% Rotate the direction vector if you hit an obstacle
theta = 5 * (pi/180); % rotate 5 degreee
R = [cos(theta) -sin(theta);
     sin(theta) cos(theta)];
 
while(dist > accur)
    % Get the direction vector
    V = [x_f-x_i; y_f-y_i];
    V = V / norm(V); 
    % Check if the new position is within the range of obstacle
    x_temp = x_i + step_size * V(1);
    y_temp = y_i + step_size * V(2);
    % As a proof of concept, assume the obstable is always cylinder
    % and there is only 1 cylinder
    % Rotate the directional vector counter clockwise until the obstacle 
    % is avoided
    do1 = real(sqrt((x_temp - obs1.c(1))^2+(y_temp - obs1.c(2))^2));
    while(do1 < obs1.R)
        V = R * V;
        x_temp = x_i + step_size * V(1);
        y_temp = y_i + step_size * V(2);
        do1 = real(sqrt((x_temp - obs1.c(1))^2+(y_temp - obs1.c(2))^2));
    end
    waypoints = [waypoints, [x_temp; y_temp]];
    x_i = x_temp;
    y_i = y_temp;
    dist = real(sqrt((x_f - x_i)^2 + (y_f - y_i)^2));
end

end