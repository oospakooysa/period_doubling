% ====================================================
%
% jump.m Skymaster Jump theory CBP 07-03-20
%
% ====================================================

% -------------- Put your data here ------------------
%
% Each row is drive period then drive amp
% Some example data is used here

A = [
4.1 0.42,
4.2 0.51,
4.7 1.06,
5.3 0.37
];

b = input('Input b');
Ad = input('Input forcing amplitude');

m = 1;
L = 5;
g = 9.8;

om0 = sqrt(g/L)
mu = b/(2*m*L^2)
alpha = -g/(6*L)
f = Ad/(m*L^2)

%f = 0.1;
%mu = 0.05;
%om0 = 1;
%alpha = 1/3;

a = [0.1:0.0001:5.5];

om1 = om0 + 3*alpha*a.^2/(8*om0) + sqrt(f^2./(4*om0^2*a.^2) - mu^2);
om2 = om0 + 3*alpha*a.^2/(8*om0) - sqrt(f^2./(4*om0^2*a.^2) - mu^2);

om3 = om0 + 3*alpha*a.^2/(8*om0);

%plot(om3,a);

% hold off;
% Restore following to use frequency scale
% plot(om1,a,om2,a,om3,a);
% pause;

T1 = 2*pi./om1;
T2 = 2*pi./om2;
T3 = 2*pi./om3;

clf;
% axis([0,10,0,2.5]);
axis([0,10,0,2.0]);
hold on;
% plot theoretical curve
plot(T1,a,T2,a,T3,a);
% Now plot data
plot(A(:,1),A(:,2),'o');
hold off;