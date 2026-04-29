clear variables;
close all;

tmin=0;
tmax=15;

% param�tres du mod�le proies-pr�dateurs
alpha=1;  % taux de reproduction des proies
beta=0.5; % taux de mortalit� des proies
gamma=2;  % taux de reproduction des pr�dateurs
delta=1;  % taux de mortalit� des pr�dateurs

% conditions initiales
x0=2;     % proies
y0=0.5;   % predateurs

% second membre de l'�qu. diff. (x',y')=(f(t,x,y),g(t,x,y))
f=@(t,x,y)(x*(alpha-y*beta));
g=@(t,x,y)(-y*(gamma-delta*x));

% Calcul des populations des proies et des pr�dateurs
h=0.01;   % pas temporel

% 1. m�thode d'Euler
[xEuler,yEuler,t]=fct_Euler_2D(x0,y0,tmin,tmax,h,f,g);

% 2. m�thode RK2
beta=1;
[xRK2,yRK2,tRK]=fct_RK2_2D(x0,y0,tmin,tmax,h,beta,f,g);


% Affichage des populations des proies et des pr�dateurs
% en fonction du temps
figure(1);hold on;
plot(t,xEuler);
plot(t,yEuler);
legend('proies','predateur');

% affichage de la trajectoire proies-pr�dateurs (tangente au champ de
% vecteurs d�fini par la fonction (x,y)->(f(t,x,y),g(t,x,y))
figure(2);hold on;

plot(xEuler,yEuler,'-r');
xlabel('proies');
ylabel('predateurs');
title('Trajectoire proies-predateur : Methode Euler');

% champ de vecteurs (x,y)->(f(t,x,y),g(t,x,y))
N=40;
ux=linspace(0,7,N);
uy=linspace(0,7,N);
[x,y]=meshgrid(ux,uy);       % grille de coordonn�es (ux,uy)
fxy=f(t,x,y);gxy=g(t,x,y);   % calcul du champ de vecteurs
norme=(fxy.^2+gxy.^2).^0.5;  % normalisation des vecteurs
fxy=fxy./norme;gxy=gxy./norme;
quiver(x,y,fxy,gxy);         % affichage de fxy et gxy sous forme
                             % de champ de vecteurs


% trajectoires proies-pr�dateurs
% 1. m�thode de d'Euler



% 2a. m�thode RK2 
figure(3);hold on;
plot(t,xRK2);
plot(t,yRK2);
legend('proies','predateur');

figure(4);hold on;

% champ de vecteurs (x,y)->(f(t,x,y),g(t,x,y))
N=40;
ux=linspace(0,7,N);
uy=linspace(0,7,N);
[x,y]=meshgrid(ux,uy);       % grille de coordonn�es (ux,uy)
fxy=f(t,x,y);gxy=g(t,x,y);   % calcul du champ de vecteurs
norme=(fxy.^2+gxy.^2).^0.5;  % normalisation des vecteurs
fxy=fxy./norme;gxy=gxy./norme;
quiver(x,y,fxy,gxy);         % affichage de fxy et gxy sous forme
                             % de champ de vecteurs

plot(xRK2,yRK2,'-r');
xlabel('proies');
ylabel('predateurs');
title('Trajectoire proies-predateur : Methode Euler');

% 2b. m�thode RK2 et nouvelles conditions initiales

% conditions initiales
x0=3;     % proies
y0=2;   % predateurs
beta=1;
[xRK2_n,yRK2_n,tRK]=fct_RK2_2D(x0,y0,tmin,tmax,h,beta,f,g);

plot(xRK2_n,yRK2_n,'-b');

legend('champ','x0=2, y0=0.5','x0=3, y0=2');