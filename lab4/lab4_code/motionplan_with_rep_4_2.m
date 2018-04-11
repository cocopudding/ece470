function [ qref ] = motionplan_with_rep_4_2( q0, qf, t1, t2, myrobot, obs1, obs2, obs3, accur )
%UNTITLED4 Summary of this function goes here
%   Gradient Descent with Momentum
q = q0;
q_temp = q0;
prev_grad = [0 0 0 0 0 0];

while (norm(q_temp(end,1:5)-qf(end,1:5))>accur)
    n = norm(q_temp(end,1:5)-qf(end,1:5))
    if (n > 0.10)
        step_size = 0.01;
    elseif (n > 0.05 && n <= 0.1)
        step_size = 0.002;
    else
        step_size = 0.0005;
    end
    grad = step_size * (att(q_temp,qf,myrobot) + rep(q_temp,myrobot,obs1) + rep(q_temp,myrobot,obs2) + rep(q_temp, myrobot, obs3));
    q_temp = q_temp + 0.6 * prev_grad + grad;
    prev_grad = grad;
    q = vertcat(q,q_temp);

t = linspace(t1,t2,size(q,1));
qref = spline(t,q');

end
