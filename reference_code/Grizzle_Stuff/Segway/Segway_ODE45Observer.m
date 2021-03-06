function [tout, xeout]=Segway_ODE45Observer(t_end,x0)
%
%
A=[0 0 1 0; 0 0 0 1; 2.568 0 0 0; -5.020  0 0 0];
B=[0;0;-0.7172;1.6744];
if 1 % Pole placement method to be covered in EECS 560
    P=[-2.5849, -1.2387 , -0.4108 + 0.2230i,  -0.4108 - 0.2230i]; % desired e-values
    K=-place(A,B,P);
else % A more powerful method from EECS 565
    K=-lqr(A,B,diag([1 1 100 1]),1), eig(A+B*K)
end
L=diag([5 5]);
refine=4;
RelTol = 10^-7;
AbsTol = 10^-8;
options = odeset('Refine',refine, 'RelTol',RelTol,'AbsTol',AbsTol);
t_start=0;
z0=0*x0(3:4)-L*x0(1:2);
xe0=[x0;z0];
[tout, xeout] = ode45(@f, [t_start t_end], xe0, options, K,L);
function dxe=f(t,xe,K,L)
%
A=[0 0 1 0; 0 0 0 1; 2.568 0 0 0; -5.020  0 0 0];
B=[0;0;-0.7172;1.6744];
A11=A(1:2,1:2); A12=A(1:2,3:4); B1 = B(1:2);
A21=A(3:4,1:2); A22=A(3:4,3:4); B2 = B(3:4);
%
z=xe(5:6);
x=xe(1:4);
%
y = x(1:2);
x2hat=z+L*y;
xhat=[y;x2hat];
u = K*xhat;
%
dz=(A22-L*A12)*z + ((A22-L*A12)*L + A21-L*A11)*y + (B2-L*B1)*u;
%
dx = A*x+B*u;
%
dxe=[dx;dz];
return
