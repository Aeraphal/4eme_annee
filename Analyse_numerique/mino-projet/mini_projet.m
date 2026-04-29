clear variables;
close all;

T = 1;
a = 1;
GM = 4 * pi * a ^ 3 / T ^ 2;

y = [0.5,0,0,11.5]';
h = 0.25;
eps = 0.05;

Fx = @(y)(y(3));
Fy = @(y)(y(4));
Gx = @(y,GM)(-GM*y(1)/(y(1)^2+y(2)^2)^(3/2));
Gy = @(y,GM)(-GM*y(2)/(y(1)^2+y(2)^2)^(3/2));

t = 0;
xn = [];
yn = [];
tmax = 10;
compteur = [0,0];

while t <= tmax
    p_E = [y(1)+h*Fx(y),y(2)+h*Fy(y),y(3)+h*Gx(y,GM),y(4)+h*Gy(y,GM)];
    p_RK = [y(1)+h*Fx(y+p_E*h/2),y(2)+h*Fy(y+p_E*h/2),y(3)+h*Gx(y+p_E*h/2,GM),y(4)+h*Gy(y+p_E*h/2,GM)];

    delta = h/2*norm(p_E-p_RK);
    h = 0.95*h*sqrt(eps/delta);
    if delta<=eps
        xn = [xn,y(1)];
        yn = [yn,y(2)];
        t = t+h;
        y = y + h*p_RK;
        compteur(2) = compteur(2)+1;
    end
    compteur(1) = 1+compteur(1);
end

figure(1)
plot(xn,yn,'r')
title("Etude du mouvement de Kepler")

