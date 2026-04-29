close all;
clear variables;


%% Partie 1.1

close all;
clear variables;

x_b = -5:1/100:5;
y_b = x_b.^2;
figure(1);
hold on;
plot(x_b,y_b);

% On cherche un moyen de trouver l'argument minimum de la fonction

eps = 0.001;
x = 4;
delta = 1;
lambda = 0.6;
compteur = 0;
y = x^2;
grad = 2*x;
l_x = [x];
l_y = [y];
l_grd = [grad];
while (delta>eps && compteur<1000)

    x = x - lambda * 2 * x;
    grad = 2*x;
    y = x ^ 2;
    l_x = [l_x,x];
    l_y = [l_y,y];
    l_grd = [l_grd,grad];
    delta = abs(grad);
    compteur = compteur + 1;
end

disp(compteur);
disp(x);
plot(l_x,l_y,'-*');

%% Partie 1.2

f = @(x)(x'*x);
df = @(x)(2*x);

n=15;
x = rand(n,1);

% On cherche un moyen de trouver l'argument minimum de la fonction

eps = 0.001;
delta = 1;
lambda = 0.1;
compteur = 0;

grad = 2*x;
l_x = [f(x)]; 
l_grd = [grad];
while delta>eps

    x = x - lambda * 2 * x;
    grad = 2*x;
    l_x = [l_x,f(x)];
    l_grd = [l_grd,grad];
    delta = grad;
    compteur = compteur + 1;
end

disp(compteur);
figure(2);
plot(l_x,grad,'*');


%% Partie 2.1

f = @(x)(atan(x));
df = @(x)(1/(1+x).^2);

n=15;
x = rand(n,1);

% On cherche un moyen de trouver l'argument minimum de la fonction

H = eye(n);

eps = 0.001;
delta = 1;
lambda = 0.1;
compteur = 0;

grad = 2*x;
l_x = [x]; 
l_grd = [grad];
while delta>eps

    x = x - lambda * 2 * x;
    grad = 2*x;
    l_x = [l_x,x];
    l_grd = [l_grd,grad];
    delta = grad;
    compteur = compteur + 1;
end

disp(compteur);
figure(2);
plot(l_x,grad,'*');




