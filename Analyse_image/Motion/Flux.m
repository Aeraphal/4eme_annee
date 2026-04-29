clear variable
close all

%% Methode de Horn et Schunck

%Lecture image
I1=imread('MiniCooper/i0001.png');
I2=imread('MiniCooper/i0002.png');

%I1=imread('RubberWhale/i0001.png');
%I2=imread('RubberWhale/i0002.png');

[X,Y]=size(I1);

figure(1)
subplot(121)
imshow(I1)
title('Image MiniCooperI0001')
subplot(122)
imshow(I2)
title('Image MiniCooperI0002')

%Definition des parametres de l'algorithme
deltaI=I2-I1;

lambda=100; %regularisation
m = 10;
moy=ones(round(m/2))/round(m/2)^2; %Laplacienacian
iteration=200;
u=zeros(X,Y);
v=zeros(X,Y);

%Calcul des gradients
% Gradient en x, gx
Ix = conv2(I1,0.25* [-1 1; -1 1],'same') + conv2(I2, 0.25*[-1 1; -1 1],'same');
% Gradient en y, gy
Iy = conv2(I1, 0.25*[-1 -1; 1 1], 'same') + conv2(I2, 0.25*[-1 -1; 1 1], 'same');
% Gradient en t, gt. Donc conservation des éléments, ajoutant uniquement
% une difference de valeur. 
It = im2double(deltaI);

%Calcul du flux optique par descente de gradient
for i=1:iteration
    %calcul ubar
    ubar=conv2(u,moy,'same');
    %Calcul vbar
    vbar=conv2(v,moy,'same');
    
    %Calcul de u
    u=ubar-Ix.*(Ix.*ubar+Iy.*vbar+It)./(lambda.^2+Ix.^2+Iy.^2);
    %Calcul de v
    v=vbar-Iy.*(Ix.*ubar+Iy.*vbar+It)./(lambda.^2+Ix.^2+Iy.^2);
end

%Affichage du flux sur l'image

figure(2)
subplot(121)
imshow(deltaI)
title('delta des deux images')
subplot(122)
hold on
imshow(I1)
quiver(u,v)
title('Flux du mouvement par la Methode de Horn et Schunck')

%% Methode de Lucas et Kanade

%Lecture image
I1=imread('MiniCooper/i0001.png');
I2=imread('MiniCooper/i0002.png');

%I1=imread('RubberWhale/i0001.png');
%I2=imread('RubberWhale/i0002.png');

[X,Y]=size(I1);

figure(3)
subplot(121)
imshow(I1)
title('Image MiniCooperI0001')
subplot(122)
imshow(I2)
title('Image MiniCooperI0002')

%Definition des parametres de l'algorithme
deltaI=I2-I1;

lambda=1; %regularisation
u=zeros(X,Y);
v=zeros(X,Y);
n=4;
nn=round(n/2);
w=ones((n+1)^2,1);
W=diag(w);
M=zeros(2);

%Calcul des gradients
Ix = conv2(I1, [-1 1; -1 1],'same') + conv2(I2, [-1 1; -1 1],'same');
Iy = conv2(I1, [-1 -1; 1 1], 'same') + conv2(I2,[-1 -1; 1 1], 'same');
It = im2double(deltaI);%conv2(I1, -0.25*ones(2),'same') + conv2(I2, 0.25*ones(2),'same');

%Calcul du flux optique pour chaque pixel
%On prend un rayon autour du pixel donc on fait en sorte de ne pas prendre
%des points hors de notre image.
for x=1+nn:X-nn
    for y=1+nn:Y-nn
        
        %Calcul des gradients de x, y et t
        gx=Ix(x-nn:x+nn,y-nn:y+nn);
        gy=Iy(x-nn:x+nn,y-nn:y+nn);
        gt=It(x-nn:x+nn,y-nn:y+nn);
        
        %On place les matrices obtenue en ligne.
        gx=gx(:);
        gy=gy(:);
        gt=gt(:);
        
        %On construit l'élément A
        A=[gx,gy];
        %On contruit l'élément b
        b=-gt;
        
        %On construit l'élément UV avec W  = diag(w)^2
        UV=A' * W * b;
        
        for i=x-nn:x+nn
            for j=y-nn:y+nn
                Mp=[(Ix(i,j))^2, Ix(i,j).*Iy(i,j);
                    Ix(i,j).*Iy(i,j),(Iy(i,j))^2];
                M = Mp+M;
            end
        end
        
        UV = pinv(M)*UV;
        
        %On place les éléments dans la matrice aux points u et v.
        u(x,y)=UV(1);
        v(x,y)=UV(2);
    end
end

%Affichage du flux sur l'image

figure()
subplot(121)
imshow(deltaI)
title('delta des deux images')
subplot(122)
hold on
imshow(I1)
quiver(u,v)
title('Flux du mouvement par la Methode de Lucas et Kanade')