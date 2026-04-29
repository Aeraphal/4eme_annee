clear variables;
close all;
% fonction f définie par y'=f(t,y)
f=@(t,y)((3*t-1)-(2*t.*y)/1+t.^2);
% initialisation
tmin=___________________;
tmax=___________________;
h=0.01; % pas de calcul
t=tmin:h:tmax;
y=zeros(4,length(t)); % 4 lignes : l ligne par méthode
y(:,1)=________________;
beta=0.5; % paramètre de la méthode de Runge-Kutta d’ordre 2
for k=1:________________
    % Euler explicite
    ______________________________________________________________________
    % Euler implicite
    ______________________________________________________________________
    % Runge-Kutta d'ordre 2 (3 lignes de code)
    ______________________________________________________________________
    % Runge-Kutta d'ordre 4 (5 lignes de code)
    ______________________________________________________________________
end
% affichage
figure(1);hold on;
plot(t,y(1,:),'c');
plot(t,y(2,:),'m');
plot(t,y(3,:),'r');
plot(t,y(4,:),'b');
lg=legend('Euler explicite','Euler implicite','RK2','RK4');