clear variables;
close all;

% fonction f définie par y'=f(t,y)
f=@(t,y)(((3*t-1)-(2*t.*y))/(1+t.^2));
% initialisation
tmin=0;
tmax=2;
h=0.01; % pas de calcul
t=tmin:h:tmax;
y=zeros(4,length(t)); % 4 lignes : l ligne par méthode
y(:,1)=[tmin;tmin;tmin;tmin];
beta=0.5; % paramètre de la méthode de Runge-Kutta d’ordre 2
for k=1:length(t)-1
    % Euler explicite
    y(1,k+1)=y(1,k)+h*f(t(k),y(k));
    % Euler implicite
    y(2,k+1)=(((1+t(k+1)^2)*y(1,k)+h*(3*t(k+1)-1))./((1+t(k+1)^2-2*h*t(k+1))));
    % Runge-Kutta d'ordre 2 (3 lignes de code)
    k1=f(t(k),y(3,k));
    k2=f(t(k)+h/(2*beta),y(3,k)+h/(2*beta)*k1);
    y(3,k+1)=y(3,k)+h*((1-beta)*k1+beta*k2);
    % Runge-Kutta d'ordre 4 (5 lignes de code)
    k1=f(t(k),y(4,k));
    k2=f(t(k)+h/2,y(4,k)+k1*h/2);
    k3=f(t(k)+h/2,y(4,k)+k2*h/2);
    k4=f(t(k)+h,y(4,k)+k3*h);
    y(4,k+1)=y(4,k)+(h/6)*(k1+2*k2+2*k3+k4);

end
% affichage
figure(1);hold on;
plot(t,y(1,:),'c');
plot(t,y(2,:),'m');
plot(t,y(3,:),'r');
plot(t,y(4,:),'b');
lg=legend('Euler explicite','Euler implicite','RK2','RK4');