close all;
clear variables;

%Vérité terrain X_bar
I=im2double(imread('flower.jpg'));

%Observation Z
z = sin(I) + randn(size(I))*0.1;


%Initialisation r0,g0,b0

%Choix des paramètres pour la résolution

x_i = rand(size(z));
gamma = 0.01;
arret = 0.001;

R = 'laplacian';
lambda = 1;
supp = 3;
type = 'gaussian';
std = 1;
H = matH(length(x_i),type,supp);

%implementation
x_i1 = x_i - gamma*grad2(x_i, z, H, lambda, R);

eps = sum((x_i-x_i1).^2).^0.5;

while eps>arret
    %Resoudre (R)
    
    %Resoudre (G)
    
    %Resoudre (B)
    
    
    x_i = x_i1;
    x_i1 = x_i - gamma*grad2(x_i, z, H, lambda, R);
    eps = sum((x_i-x_i1).^2).^0.5;
end

subplot(221)
imshow(I)
subplot(222)
imshow(z)
subplot(223)
imshow(x_i1)