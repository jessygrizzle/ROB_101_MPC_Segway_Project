% Top level script for running the Segway model
% 
% In the file Segway_ODE45, you can select to simulate a 
% nonlinear model or a linear model
%

%% Set Initial Conditon & Simulate
x0 = [0;10;0;0] ; %[phi, theta, dphi/dt, dtheta/dt]
t_end = 25;
[tout, xout] = Segway_simulate(t_end,x0);

%% Plot State/Output variables
Segway_plot(tout,xout);

%% Animation
Segway_anim(tout,xout(:,1),xout(:,2));
% Segway_anim(tout,xout(:,1),xout(:,2),.01);    % animate in slow motion
