clear variables;
close all;

% fonction f1 définie par y'=z(t)
f1=@(t,y,z,theta)(z);
% fonction 2 définie par z'=theta(t)
f2=@(t,y,z,theta)(theta);
% fonction 3 définie par theta'=y'''
f3=@(t,y,z,theta)(t.*exp(-t.^2)-1./y);

% initialisation
tmin=0;
tmax=10;
h=0.1; % pas de calcul
t=tmin:h:tmax;
y=zeros(3,length(t)); % 4 lignes : l ligne par méthode
y(:,1)=[1;0;1];
beta=0.5; % paramètre de la méthode de Runge-Kutta d’ordre 2
for k=1:length(t)-1
    % Euler explicite
    y(1,k+1)=y(1,k)+h*f1(t(k),y(1,k),y(2,k),y(3,k));
    y(2,k+1)=y(2,k)+h*f2(t(k),y(1,k),y(2,k),y(3,k));
    y(3,k+1)=y(3,k)+h*f3(t(k),y(1,k),y(2,k),y(3,k));
end

R=zeros(3,length(t)); % 4 lignes : l ligne par méthode
R(:,1)=[1;0;1];
% 
% for k=1:length(t)-1
%     % Euler explicite
%     k11=f1(R(1,k),R(2,k),R(3,k));
%     k12=f1(t(k)+h/(2*beta),R(1,k)+h/(2*beta)*k11);
%     k21=f2(t(k),R(2,k));
%     k22=f2(t(k)+h/(2*beta),R(2,k)+h/(2*beta)*k21);
%     k31=f3(t(k),R(3,k));
%     k32=f3(t(k)+h/(2*beta),R(3,k)+h/(2*beta)*k31);
%     R(1,k+1)=R(1,k)+h*((1-beta)*k11+beta*k12);
%     R(2,k+1)=R(2,k)+h*((1-beta)*k21+beta*k22);
%     R(3,k+1)=R(3,k)+h*((1-beta)*k31+beta*k42);
% end


% affichage
figure(1);hold on;grid on;
plot(t,y(1,:),'c');
% plot(t,R(1,:),'m');
lg=legend('Euler','RK');