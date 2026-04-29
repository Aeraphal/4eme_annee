clear variables;
close all;

tmin=0;tmax=1;
f=@(t,y)(t.^3*exp(-5*t)-(4*t.^3+5).*y);
yExact=@(t)(1/4*(exp(t.^4)+3).*exp(-t.*(t.^3+5)));
    
% condition initiale
y0=1;

%% question 1

figure(1);

% 1. méthode d'Euler (h=0.1)
h=0.1;
[yEuler1,t1]=fct_Euler(y0,tmin,tmax,h,f);
eps1=abs(yEuler1-yExact(t1));   % erreur


% 2. méthode d'Euler (h=0.05)
h=0.05;
[yEuler2,t2]=fct_Euler(y0,tmin,tmax,h,f);
eps2=abs(yEuler2-yExact(t2));   % erreur


% 3. méthode RK2 (h=0.1 et beta=1)
h=0.1;beta=1;
[yRK,t3]=fct_RK2(y0,tmin,tmax,h,beta,f);
eps3=abs(yRK-yExact(t3));       % erreur

subplot(211);
hold on;
plot(t2,yExact(t2));
legend('exact');
plot(t1,yEuler1);
legend('Euler 0.1');
plot(t2,yEuler2);
legend('Euler 0.05');
plot(t3,yRK);
legend('RK 0.1');

subplot(212);
hold on;
plot(t1,eps1);
legend('Euler 0.1');
plot(t2,eps2);
legend('Euler 0.05');
plot(t3,eps3);
legend('RK 0.1');

% 4. Comparaison méthode d'Euler et RK2 (h=0.001)
tmax=0.1;
h=0.001;
[yEuler_p,t_p]=fct_Euler(y0,tmin,tmax,h,f);
eps_p1=abs(yEuler_p-yExact(t_p));   % erreur

[yRK_p,t_pp]=fct_RK2(y0,tmin,tmax,h,beta,f);
eps_p2=abs(yRK_p-yExact(t_pp));       % erreur

figure(2);
hold on;
plot(t_p,eps_p1,'.');
legend('Euler');
plot(t_pp,eps_p2,'.');
legend('RK');