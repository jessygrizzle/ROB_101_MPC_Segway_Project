% Top level script for running the Segway model
% 
% In the file Segway_ODE45, you can select to simulate a 
% nonlinear model or a linear model
%

% Set Initial Conditon
x0=[0;10;1;-1] ; %[phi, theta, dphi/dt, dtheta/dt]
t_end=15;
%[tout, xout]=Segway_ODE45(t_end,x0);

[teout, xeout]=Segway_ODE45Observer(t_end,x0);

% Plot various variables and then run an animation

cart_position = [1 1 0 0 0 0]*xeout';
cart_velocity = [0 0 1 1 0 0 ]*xeout';
phi = [1 0 0 0 0 0]*xeout';
theta = [0 1 0 0 0 0]*xeout';
phi = [1 0 0 0 0 0]*xeout';
theta = [0 1 0 0 0 0]*xeout';
dphi = [0 0 1 0 0 0]*xeout';
dtheta = [0 0 0 1 0 0]*xeout';
z1 = [0 0 0 0 1 0]*xeout';
z2 = [0 0 0 0 0 1]*xeout';
dphihat=z1+5*phi;
dthetahat=z2+5*theta;


figure(1);
plot(teout,cart_position,'linewidth',2.5);
xlabel('Time (Sec)','fontsize',16);
ylabel('p (m)','fontsize',16);
title('Segway Cart Position','fontsize',18);
grid on
figure(2);
plot(teout,cart_velocity,'linewidth',2.5);
xlabel('Time (Sec)','fontsize',16);
ylabel('dp/dt (m/s)','fontsize',16);
title('Segway Cart Velocity','fontsize',18);
grid on

figure(3);
plot(teout,phi,'linewidth',2.5);
xlabel('Time (Sec)','fontsize',16);
ylabel('\phi (rad)','fontsize',16);
title('Segway Pendulum Angle','fontsize',18);
grid on
figure(4);
plot(teout,theta,'linewidth',2.5);
xlabel('Time (Sec)','fontsize',16);
ylabel('\theta (rad)','fontsize',16);
title('Segway Wheel Angle','fontsize',18);
grid on

figure(5);
plot(teout,dphi,'r',teout,dphihat,'g','linewidth',2.5);
xlabel('Time (Sec)','fontsize',16);
ylabel('d\phi/dt (rad)','fontsize',16);
title('Segway Pendulum Angle Velocity','fontsize',18);
legend('True', 'Est')
grid on
figure(6);
plot(teout,dtheta,'r',teout,dthetahat,'g','linewidth',2.5);
xlabel('Time (Sec)','fontsize',16);
ylabel('d\theta/dt (rad)','fontsize',16);
title('Segway Wheel Angle Velocity','fontsize',18);
legend('True', 'Est')
grid on


% Animation to see what is happening
pause(1)

Segway_anim(teout,xeout(:,1),xeout(:,2));

% Animate again, this time in slow motion

pause(1)
% Slow motion
%Segway_anim(teout,xeout(:,1),xeout(:,2),.01);



