close all;
clear variables;

x = 0:0.01:1;

P1 = [-2;1];
P2 = [-1;3];
P3 = [2;4];
P4 = [4;2];
P5 = [2;0];
P6 = [-1;-1];


P = [P1,P2,P3,P4,P5,P6,P1];

Bez = [1,-3,3,-1;
    0,3,-6,3;
    0,0,3,-3;
    0,0,0,1];


t = [x.^0;x.^1;x.^2;x.^3];

B = zeros(2,12);
C = zeros(2,12);
for k = 1:1:6
    B(:,k) = 1/3*(2*P(:,k)+P(:,k+1));
    C(:,k) = 1/3*(2*P(:,k+1)+P(:,k));
end
B(:,7:12) = B(:,1:6);
C(:,7:12) = C(:,1:6);

A = zeros(2,12);
for k = 1:1:6
    A(:,k) = 1/2*(C(:,k)+B(:,k+1));
end
A(:,7:12) = A(:,1:6);

figure(1);
hold on;

plot(P(1,1:7),P(2,1:7),'o--');
plot(C(1,1:7),C(2,1:7),'^');
plot(B(1,1:7),B(2,1:7),'v');
plot(A(1,1:7),A(2,1:7),'pentagram');

M = @(p,t)(p*Bez*t);



for k=1:1:6
    Test = M([A(:,k),B(:,k+1),C(:,k+1),A(:,k+1)],t);
    plot(Test(1,:),Test(2,:),'DisplayName', strcat('Bezier ', num2str(k))); 
end
legend('show');






