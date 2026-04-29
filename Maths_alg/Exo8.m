clear variables;
close all;
% motif de base
F0=2*[-0.5,-0.5,-5,-3,-10,-8,-9,-6,-6,-2,-5,-2,0,2,5,2,6,6,9,8,10,3,5,0.5,0.5; % abscisses
0,10,9,12,17,17,20,20,22,17,27,25,30,25,27,17,22,20,20,17,17,12,9,10,0]; % ordonnées
[m,n]=size(F0);
% dimension du cadre d'affichage
L=200;
cadre=[-L,L,-L,L];
% affichage du motif de base
color=[0,0,0];
fill(F0(1,:),F0(2,:),color);
axis('equal');
axis(cadre);
hold on;

question=1;
switch question
    case 1
        u = [-80, 60];
        F1 = F0+u;
        color=[1,0,0];
        fill(F1(1,:),F1(2,:),color);
        
        N=[sqrt(2)/2, sqrt(2)/2];
        plot(x,y,'-g');
        F2=(2*(N*N')-eye(2))*F1;
        color=[0,1,0];
        fill(F2(1,:),F1(2,:),color)
        
    case 2

    case 3

end
