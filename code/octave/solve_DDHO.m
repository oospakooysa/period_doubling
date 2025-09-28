% =============================================================================
%
% Skymaster without motor
%
% CBP 11-04-18
%
% solve_DDH0.m

global m g L b Ad omegaD

tstart = 0;
tend = input('Input end time');

Ad = input('Input driving amplitude Ad');
omegaD = 2*pi/input('Input driving period')
%thetaInit = input('Input initial theta');
thetaInit = 0

m = 1;
g = 9.8;
L = 0.2824;
b = 0.1;

xinit = [thetaInit,0];

options = odeset('RelTol',1e-6,'AbsTol',1e-6,'InitialStep',tend/1e4,'MaxStep',tend/1e4);

[t,x] = ode45(@rhs_ddho,[tstart,tend],xinit,options);

plot(t,x(:,1),'r');


