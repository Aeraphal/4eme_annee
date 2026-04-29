clear;
close all;

%Charge les donnees du fichier data.m
data;

%affichage des donnees
plot(DATA(1,:),DATA(2,:),'r.');
hold on
plot(DATA(1,:),DATA(2,:),'b-');
axis equal;

