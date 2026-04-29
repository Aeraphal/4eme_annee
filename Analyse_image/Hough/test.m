clear variables;
close all;

%% Lecture de l'image

%I = imread('circuit.tif');
I = imread('buildings.png');
I = I(:,:,1);
[lignes,colonnes]=size(I);
figure()
imshow(I)

%% Definition des parametres de l'algorithme

rhomax = floor(sqrt((lignes-1)^2+(colonnes-1)^2));

drho = 1;
dteta = 1;
rho = -rhomax:drho:rhomax;
teta = 1:dteta:180;

%% Creation de l'image des contours

%[Grad,A] = imgradient(I,'prewitt');
BW = edge(I,'prewitt');
%BW = edge(I,'canny');

figure()
imshow(BW)

%% Calcul de la matrice d'accumulation

H = zeros(length(rho),length(teta));
for i=1:lignes
    for j=1:colonnes
        if BW(i,j)==1
            for o=teta
                t=o*pi/180;
                p=round(i*cos(t)+j*sin(t));
                    if abs(p)<rhomax
                        H(round((p+rhomax)/drho),o)=H(round((p+rhomax)/drho),o)+1;
                    end
            end
        end
%         Ci = BW(i)*cos(teta) + BW(j)*sin(teta);
%         for k=1:length(Ci)
%             floor(rhomax* Ci(k));
%             H(floor(Ci(k))+rhomax,k)= H(floor(Ci(k))+rhomax,k)+1;
%         end
    end
end
%[H,teta,rho]=hough(BW);

%% Extraction des maximas locaux

Hfilter = ordfilt2(H,25,ones(5,5));
Hmaxloc = Hfilter - 60;
[l,c] = size(H);

liste_teta = [];
liste_rho = [];

for i=1:l
    for j=1:c
        if Hmaxloc(i,j)<0
            Hmaxloc(i,j)=0;
        else
            Hmaxloc(i,j)=1;
            liste_rho = [liste_rho,i]; 
            liste_teta = [liste_teta,j];
        end
    end
end

%% Calcul des points extremaux de chaque droite

x1=1;
x2=lignes;
liste_y1=[];
liste_y2=[];

for i=1:length(liste_teta)
    for j=1:length(liste_rho) 
        t=liste_teta(i)*pi/180;
        r=liste_rho(j);
        ajout1=(1/sin(t))*(r-x1*cos(t));
        ajout2=(1/sin(t))*(r-x2*cos(t));
        liste_y1=[liste_y1,ajout1];
        liste_y2=[liste_y2,ajout2]; 
    end
end

%% Affichage des droites sur l'image

figure(1)
subplot(121)
imshow(H,[])
colorbar();
colormap default;
subplot(122)
imshow(Hmaxloc,[])
colorbar();

figure(2)
imshow(I)
hold on;
for i=1:length(liste_y1)
    plot([x1 x2],[liste_y1(i) liste_y2(i)])
end