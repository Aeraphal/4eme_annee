clear variables;
close all;

t = 0:0.05:2*pi;
[n,m] = size(t);
gamma0 = 0.05;
gamma1 = randn(n,m)*gamma0;
gamma2 = randn(n,m)*gamma0;
epsilon = 1; % + ou - 1
psi = 0; % [O,pi]

s1 = zeros(n,m);
s2 = zeros(n,m);
for i = 1:1:m
    s1(i) = sin(i*0.05) + gamma1(i);
    s2(i) = epsilon*sin(i*0.05+psi) + gamma2(i);
end



figure(1);
subplot(121);
hold on;
plot(t,s1);
plot(t,s2);
title('Signaux');

subplot(122);
plot(s1,s2,'o');
title('Image de points');
xlabel('s1'); ylabel('s2');

Y = [s1;s2]';
[n,m] = size(Y);

X = Y - mean(Y);

M = X'*X/n;

[P,D] = eig(M);
lambda = flipud(diag(real(D)));
P = fliplr(P);
figure(2);
stem(lambda);
%disp(P);

Tau = lambda./sum(lambda);
figure(3);
stem(Tau*100);

Xstar = X*P;

figure(4);

plot(Xstar(:,1),Xstar(:,2),'*');
title('Analyse en composantes principales');
xlabel('e1'); ylabel('e2');
axis equal;

Z = X./(ones(n,1)*std(Y));

Corr = zeros(n,m);
for j = 1:n
    for k = 1:2
        Corr(j,k) = Z(:,j)'*(X(:,k)/(n*sqrt(lambda(k))));
    end 
end
