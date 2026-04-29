close all; clear variables; clc;

question = 2;

switch question
    case 1

        % construction des matrices A et B (SANS BOUCLE FOR NI WHILE)eros
        A=[1 3 0 0; -2 2 3 0; 0 -2 3 3; 0 0 -2 4];
        B=[2 2 2 2; 2 2 2 2; 2 2 2 2];
        % concaténation des matrices A et B
        M=[A;B];
        % décomposition en valeurs singulières de M
        [U,D,V] = svd(M);
        d=diag(D);
        % reconstruction de la matrice M
        M2=zeros(size(M));
        for i=1:4
        M2=M2 + d(i)*U(:,i)*V(:,i)' ;
        end

        disp(M2);
    case 2
        
        A = imread('Einstein.jpg'); %mxnx3
        figure(1);
        imshow('Einstein.jpg');
        %On ne prend qu'une seule des trois images
        A = A(:,:,1);
        %On récupère des valeurs
        [U,S,V] = svd(double(A));
        [m,n] = size(A);
        figure(2);
        i=1:m;
        plot(i,S,'r');
        %On stock la diagonale
        D=diag(S);
        figure(3);
        tab = [5,40,100,200];
        Compression = [];
        %On effectue une dissociation des 4 cas souhaité pour alléger les
        %calculs.
        for i=1:4
            Ak = zeros(size(A));
            k = tab(i);
            for j=1:k
                %On effectue le calcul suivant la valeur de k
                Ak=Ak + D(j)*U(:,j)*V(:,j)';
            end
            Tau = 1-(k*(1+m+n)/(m*n));
            subplot(2,2,i);
            %On le modifie en nombre entier.
            imshow(uint8(Ak));
            title(k);
            Compression = [Compression, Tau];
        end
        figure(4);
        plot(tab,Compression,'*r');
        %Tentative de relier les points. Cela supprime les points.
%         for i=1:3
%             plot(Compression(i), Compression(i+1), '-r');
%         end
        %On a essayé par la suite avec une image de poisson!
        
end
