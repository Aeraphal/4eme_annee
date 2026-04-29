clear variables;
close all;

%% Liste des variables constantes

eta=1.81*10^-2;
masse=0.2;
rayon=0.05;
l=0.5;
g=9.8;

Theta0=2*pi/3;
Thetaprime0=0;


tmin=0;
tmax=100;


gamma= 6*pi*rayon*eta /masse;
w=sqrt(g/l);

%% Theta"(t) + gamma*Theta'(t) + w² sin(Theta(t)) = 0

% fonction f1 definie par Theta'=z(t)
f1=@(t,Theta,Thetaprime)(Thetaprime);
% fonction 2 definie par z'=-gamma*theta'(t) + w²sin(Theta)
f2=@(t,Theta,Thetaprime)(-gamma*Thetaprime - w^2*sin(Theta));


%% Euler

h=0.02;
[Thetaprime,Theta,t]=Euler_2D(Thetaprime0,Theta0,tmin,tmax,h,f1,f2);

figure(1);hold on;
plot(t,Theta,'c');
plot(t,Thetaprime,'m');
lg=legend('Theta','Thetaprime');


Theta_x=l*sin(Theta);
Theta_y=-l*cos(Theta);

c=length(Theta_x);

Ener_cin = 1/2*masse*l^2*Thetaprime.^2;
Ener_pot = masse*g*l*(1-cos(Theta));
Ener_tot = Ener_cin + Ener_pot;

% figure(2)
% for a = 1:1:c
% 
%     plot([0,Theta_x(a)],[0,Theta_y(a)],'linewidth',2);
%     axis([-1 1 -1 1]);
%     pause(0.0001);
% end
% % title('Pendule Siple amorti');




% figure(1);
% v=VideoWriter('pendule.avi');
% open(v);
% compteur = 0;
% for a=1:1:c
%      plot([0,0],[sin(Theta_x(a)),cos(Theta_y(a))],'linewidth',2);
%      compteur = compteur +1 ;
%      drawnow;
%      thisframe=getframe(gcf);
%      writeVideo(v,thisframe);
% end
% close(v);







