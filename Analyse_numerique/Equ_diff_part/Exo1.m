close all;
clear variables;

m = 1;
h = 0.05;

tmax = 0.11;
tau = 0.00124;
r = tau/h^2;

t = 0:tau:tmax;
x = 0:h:m;
n = length(x);
f_0 = 0;
f_m = 0;

D = ones(n,1);
M = diag(D(1:n-1)*r,-1)+diag(D(1:n)*(1-2*r))+diag(D(1:n-1)*r,1);

%F = 1-abs(2*x-1)';
F = sin(pi*x)'; 
F_t = zeros(n,1);
F_p = F_t+[0;F(2:n-1);0];
figure(1);
hold on;
plot(x,F,'DisplayName', strcat('t = ', num2str(t(1)),'s'));


for i = t
    F = M*F+r*F_t;
    F(1) = 0;
    F(end) = 0;
    if mod(i,10*tau) == 0
        plot(x,F,'DisplayName', strcat('t = ', num2str(i+tau),'s'));
    end
end
legend('show');
title('Equation de la chaleur');

% M = diag(D(1:n-1)*r,-1)+diag(D(1:n)*(1-2*r))+diag(D(1:n-1)*r,1);

% for i = t
%     F = M*F+r*F_t;
%     if mod(i,30*tau) == 0
%         plot(x,F,'DisplayName', strcat('t = ', num2str(i+tau),'s'));
%     end
% end
