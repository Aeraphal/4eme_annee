close all; clear variables; clc;

question = 1;

switch question
    case 1
        figure(1);hold on;
        a=2;b=-5;c=1;
        x2=-3:0.1:3;
        y2=-2.5:0.1:4;
        z2=-8:1:8;
        [X2,Y2]=meshgrid(x2,y2);
        Z2=-(a*X2+b*Y2)/c;
        C(:,:,1)=zeros(size(Z2)); % red
        C(:,:,2)=0.8*ones(size(Z2)); % green
        C(:,:,3)=0.8*ones(size(Z2)); % blue
        mesh(X2,Y2,Z2,C);
        
        coords = [];
        n = 10;
        coords = rand(n,3);
        % -2<x<2
        coords(:,1)=coords(:,1)*4-2;
        % -2<y<2
        coords(:,2)=coords(:,2)*4-2;
        % -8<z<6
        coords(:,3)=coords(:,3)*14-8;
        % Projection en 3D
        plot3(coords(:,1),coords(:,2),coords(:,3),'*b');
        % Pivotement de la grille afin de la visualiser en 3D.
        view(-30,30);
        
        % Calcul de la norme à partir de a, b, c
        Nr = [2; -5; 1]/norm([2, -5, 1]);
        % Calcul de la matrice de projection orthogonal
        P = eye(3) - Nr*Nr';
        % Transposé des Qi sur le plan
        disp(P);
        disp(coords);
        Qi = P*coords';
        plot3(Qi(1,:), Qi(2,:), Qi(3,:),'.r');
        plot(Qi,coords(i,:), '-g');
        
        
        delta=0.1;
        per=Qi+rand()*delta-delta/2;
        
        
        %Pour la suite
%         theta = acos(N'*N2);
%         if theta>pi/2
%             theta = pi-theta
%         end
end











