close all;
clear variables;

x = 0:0.01:1;
a = -3;

A = [0;1];
B = [0;0];
C = [a,0];
D = [-1;1];

p = [A,B,[a;0],D];

Bez = [1,-3,3,-1;
    0,3,-6,3;
    0,0,3,-3;
    0,0,0,1];

M = @(p,t)(p*Bez*t);

t = [x.^0;x.^1;x.^2;x.^3];



figure(1);
hold on;
for a=-3:1:0
    p = [A,B,[a;0],D];
    m = M(p,t);
    plot(m(1,:),m(2,:),'DisplayName', strcat('a = ', num2str(a))); 
end
a = 1;
p = [A,B,[a;0],D];
m = M(p,t);
plot(m(1,:),m(2,:),'DisplayName', strcat('a = ', num2str(a))); 
legend('show');

p = [A,B,[a;0],D];
plot(p(1,:),p(2,:),'o--');