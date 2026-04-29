clear variables;
close all;

%% Potit 1
n = 500; % Nombre de fléchettes
X = rand(n);
Y = rand(n);
figure(1);
compteur = 0;

for i = 1:n
    if X(i)^2 + Y(i)^2 < 1
        hold on;
        plot(X(i),Y(i),'*g');
        compteur = compteur + 1;
    else
        hold on;
        plot(X(i),Y(i),'*r');
    
    end
end

hold on;
theta = linspace(0,pi/2);
x=cos(theta);
y=sin(theta);
plot(x,y);
Pi = compteur/n*4;


disp('APPROXIMATION DE PI (METHODE DE MONTE-CARLO)');
X1 = ['Nombre total de fléchettes : ',num2str(n)];
X2 = ['Nombre de fléchettes dans le quadrant : ',num2str(compteur)];
X3 = ['Valeur approximative de pi : ',num2str(Pi)];

disp(X1);
disp(X2);
disp(X3);


%% Potit 2

n = 5000; % Nombre de fléchettes
X = 1 + rand(n).*(exp(1)-1);
Y = 0.5*rand(n);
figure(2);
compteur = 0;

for i = 1:n
    if Y(i) < log(X(i))/X(i)^2
        hold on;
        plot(X(i),Y(i),'*g');
        compteur = compteur + 1;
    else
        hold on;
        plot(X(i),Y(i),'*r');
    
    end
end

hold on;
theta = linspace(1,exp(1));
x=theta;
y=log(x)./x.^2;
plot(x,y);

Aire = (exp(1)-1)*0.5;
Int = compteur/n*Aire;

disp('APPROXIMATION DE PI (METHODE DE MONTE-CARLO)');
X1 = ['Nombre total de fléchettes : ',num2str(n)];
X2 = ['Nombre de fléchettes sous la courbe : ',num2str(compteur)];
X3 = ['Valeur approximative de l intégrale : ',num2str(Int)];

disp(X1);
disp(X2);
disp(X3);
disp('Valeur exacte de l intégrale : 0.2642');


