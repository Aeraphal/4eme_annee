close all;
clear all;

I1 = imread('braille/braille2.png');
I1 = I1(:,:,1);
% Calcul du bottomhat
%Strel créé des cercles
SE = strel('disk', 15,4);
SE2 = strel('disk', 4,4);
bot = imbothat(I1,SE);
% Floutage du bottomhat
botF = imgaussfilt(bot,2);
% Tophat de l'image précédente
top = imtophat(botF,SE2);
% Seuillage
[l,c] = size(top);
seuil = 5;
for i=1:l
    for j=1:c
        if top(i,j)>seuil
            top(i,j)=255;
        else
            top(i,j)=0;
        end
    end
end
% Dilatation morphologique
% Résultat similaire à un flou image
top = imdilate(top,SE2);
% Détection des cercles
% imfindcircles créé des cercles 
[centre,rad,metr] = imfindcircles(top,[1 10]);
% Affichage des résultats
figure()
imshow(I1)
hold on;
plot(centre(:,1),centre(:,2),'o')