function brf=genbrfil;
% function brf=genbrf;
% TP estimation spectrale
% generation d'un bruit blanc gaussien centre de variance unite 
% filtre passe-bas de 100000 points
% affichage de la sequence de bruit


clc,home
N=100000;
disp(['Generation d''une realisation de bruit blanc gaussien'])
disp(['de moyenne nulle et de variance unite de ',num2str(2*N),' echantillons']);
% generation de 200000 echantillons
%
% initialisation du generateur de bruit gaussien
%
disp(' ');
init=input('Donnez un entier pour initialiser le generateur de bruit blanc gaussien : ');
disp(' ');
randn('seed',init);
al=randn(2*N,1);
al=al-mean(al);
al=al/std(al);
% affichage de l'histogramme du bruit blanc N(0,1)
[p,z]=hist(al,30);
scrsz = get(0,'ScreenSize');
fig1=figure('Position',[0.02*scrsz(3) 0.05*scrsz(4) 0.98*scrsz(3) 0.95*scrsz(4)/2]);
bar(z,p),
title(['Histogramme de la realisation blanche gaussienne de ',num2str(2*N),' echantillons']);
disp(' ')
disp('appuyez sur une touche pour continuer');
disp(' ')
pause
close(fig1);
% filtrage
disp(['filtrage du bruit blanc et affichage de la sequence de ',num2str(N),' echantillons'])
load LPbutt
fal=filter(b,a,al);
% extraction des nbpt points
brf=fal(fix(N/2):fix(N/2)+N-1);
% affichage
scrsz = get(0,'ScreenSize');
fig1=figure('Position',[0.02*scrsz(3) 0.05*scrsz(4) 0.98*scrsz(3) 0.95*scrsz(4)/2]);
%fig1=figure('Units','normal','Position',[0.01 0.44 0.98 0.43]);
plot(0:N-1,brf);axis([0 length(brf)-1 min(brf) max(brf)]);
title('le bruit filtre passe-bas e analyser');
xlabel('indices')
disp(' ')
disp('appuyez sur une touche pour terminer');
pause;
close(fig1)
clear al fal

        
    
        
        

