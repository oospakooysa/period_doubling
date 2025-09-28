% =============================================================================
%
% Skymaster without motor
%
% CBP 11-04-18
%
% solve_DDHO_Sweep.m

global b m g L Ad  theta omega

tstart = 0;
tend = input('Input end time');

Ad = input('Input driving amplitude Ad');
b = input('Input damping b');
m = 1;
g = 9.8;
L = 5.0;


xinit = [0,0];

options = odeset('RelTol',1e-6,'AbsTol',1e-6,'InitialStep',tend/1e4,'MaxStep',tend/1e4);

[t,x] = ode45(@rhs_ddho_1,[tstart,tend],xinit,options);

clf;

plot(t,x(:,1),'r');


