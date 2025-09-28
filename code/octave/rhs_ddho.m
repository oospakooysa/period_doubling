% ==============================================
%
% CBP 11-08-18 Skymaster without motor
%
% Sweeping Period


function xd=rhs_ddho(t,x)

global m g L Ad b omegaD

xd = zeros(2,1);


theta = x(1);
omega = x(2);


drive = Ad*cos(omegaD*t);

xd(1) = x(2);
xd(2) = (drive - b*omega - m*g*L*sin(theta))/(m*L^2);
