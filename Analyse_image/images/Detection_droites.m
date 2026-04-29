close all;
clear variables;


%Lecture du documents et récupèration de son size
build = imread("buildings.png");
I = rgb2gray(build);

[L,l] = size(I);

figure();
imshow(I);
title('image originale');
xlabel('x');
ylabel('y');


%Calcul de rau = (x*cos(theta) + y*sin(theta))
rho_max = floor(sqrt((L-1)^2+(l-1)^2));
drho = 2;
rho = -rho_max:drho:rho_max;

%Calcul de theta
dtheta = 1;
theta = 1:dtheta:90;


%Calcul des bords 
BW = edge(I,'canny');

figure()
imshow(BW)
title('Image des contours')
xlabel('x')
ylabel('y')


%Calcul de la matrice d'accumulation
H = zeros(length(rho),length(theta));
for i=1:L
    for j=1:l
        if BW(i,j)==1
            for k=theta
                t=k*pi/90; %conversion de l'angle theta 
                p=round(j*cos(t)+i*sin(t)); %calcul de rho
                    if abs(p)<rho_max
                        H(round((p+rho_max)/drho),k)=H(round((p+rho_max)/drho),k)+1; %ajout d'un point dans la matrice d'accumulation
                    end
            end
        end
    end
end



%Seuillage de l'image

D = (H > 150);
figure()
subplot(121)
imshow(H/255)
title('Matrice d accumulation')
xlabel('x')
ylabel('y')
subplot(122)
imshow(D)
title('Matrice d accumulation seuillé')
xlabel('x')
ylabel('y')

%Extraction des extremas locaux

rho_f = [];
theta_f = [];
[L,l] = size(D);

for i = 1:L
    for j = 1:l
        if (D(i,j) == 1)
            rho_f = [rho_f, rho(i)];
            theta_f = [theta_f, theta(j)];
        end
    end
end

X=[];
Y=[];
for k=1:length(theta_f)
        
        t=theta_f(k)*pi /180;
        r=rho_f(k);
        X = [X, r/cos(t)];
        Y = [Y, r/sin(t)];
        
end

% Affichage des droites sur l'image

figure(5)
imshow(I)
hold on;
for k=1:length(X)

    plot([0,X(k)],[Y(k),0]);
    hold on;
end
title('Image avec detection des lignes')
xlabel('x')
ylabel('y')

%Test

%BW = edge(I,'canny');

%[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);

% subplot(2,1,1);
% imshow(build);
% title('building.png');
% subplot(2,1,2);
% imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
% title('Hough transform of building.png');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% colormap(gca,hot);