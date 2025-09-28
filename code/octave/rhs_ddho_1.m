% ==============================================
%
% CBP 11-08-18 Skymaster without motor
%
% Sweeping Period
%
% rhs_ddo_1.m


function xd=rhs_ddho_1(t,x)

global b m g L Ad  theta omega  

xd = zeros(2,1);

theta = x(1);
omega = x(2);

if(t < 1000) Td = 4.1; 
elseif( (t > 1000) && (t < 1500))  Td = 4.2;
elseif( (t > 1500) && (t < 2000)) Td = 4.3;
elseif( (t > 2000) && (t < 2500)) Td = 4.4;
elseif( (t > 2500) && (t < 3000)) Td = 4.5;
elseif( (t > 3000) && (t < 3500)) Td = 4.6;
elseif( (t > 3500) && (t < 4000)) Td = 4.7;
elseif( (t > 4000) && (t < 4500)) Td = 4.8;
elseif( (t > 4500) && (t < 5000)) Td = 4.9;
elseif( (t > 5000) && (t < 5500)) Td = 5.0;
elseif( (t > 5500) && (t < 6000)) Td = 5.1;
elseif( (t > 6000) && (t < 6500)) Td = 5.2;
elseif( (t > 6500) && (t < 7000)) Td = 5.3;
elseif( (t > 7000) && (t < 7500)) Td = 5.4;
elseif( (t > 7500) && (t < 8000)) Td = 5.5;
elseif( (t > 8000) && (t < 8500)) Td = 5.6;
elseif( (t > 8500) && (t < 9000)) Td = 5.7;
elseif( (t > 9000) && (t < 9500)) Td = 5.8;
elseif( (t > 9500) && (t < 10000)) Td = 5.9;
else Td = 6.0;
endif

omegaD = 2*pi/Td;

drive = Ad*cos(omegaD*t);

xd(1) = x(2);
xd(2) = (drive - b*omega - m*g*L*sin(theta))/(m*L^2);
% below approximation
% xd(2) = (drive - b*omega - m*g*L*(theta - theta^3/6))/(m*L^2);

%Assert S-paper solution
%f = 0.1;
%mu = 0.05;
%om0 = 1;
%al = 1/3;

%xd(2) = f*cos(omegaD*t) - 2*mu*x(2) - om0*x(1) - al*x(1)^3;