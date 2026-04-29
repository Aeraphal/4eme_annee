close all;
clear variables;

x = 0:0.01:1;
yf = @(t)(3*t*(2*t-1)*(t-1));

p = [0,1/3,2/3,1;
    0,1,-1,0];

Bez = [1,-3,3,-1;
    0,3,-6,3;
    0,0,3,-3;
    0,0,0,1];

M = @(p,t)(p*Bez*t);

t = [x.^0;x.^1;x.^2;x.^3];

test = M(p,t);

figure(1);
hold on;
plot(test(1,:),test(2,:));
grid on;
plot(p(1,:),p(2,:),'o--');

x2 = x+1;

p2 = [2,5/3,4/3,1;
    0,-1,1,0];

t2 = [x2.^0;x2.^1;x2.^2;x2.^3];

test2 = M(p2,t2);

plot(test2(1,:),test2(2,:));
plot(p2(1,:),p2(2,:),'o--');
