close all;
clear variables;

L = 5;
h = 0.02;

tmax = 10;
tau = 0.005;

c = 1;
r = (tau*c/h)^2;

t = 0:tau:tmax;
x = 0:h:L;
w= length(t);
n = length(x);
f_0 = 0;
f_m = 0;

D = ones(n,1);
M = diag(D(1:n-1)*r,-1)+diag(D(1:n)*(2-2*r))+diag(D(1:n-1)*r,1);

f = @(g,x,t)(1/2*(g(x-t) + g(x+t)));

g2 = @(x,mu,sigma)(exp(-(x-mu).^2/(2*sigma.^2)));
g = g2(x,L/2,0.5);
k = zeros(1,n);

F1 = g'; 
F2 = g' + tau*k';
figure(1);

axis([0,5 -1 1]);
plot(x,0);

for i = 1:w
    F = M*F2-F1;
    F(1) = f_0;
    F(n) = f_m;
    plot(x,F);
    axis([0 L -1 1]);
    pause(0.001);
    F1 = F2;
    F2 = F;
end
title('Equation donde');