close all;
clear variables;

%Initialisation de l'amplitude de la variation appliquée et du lambda pour la méthode de Tikhonov.

var = 0.01;

lambda = 0.001;

%Choix de la partie de l'exercice.
n = input('Entrez la partie de l exercice traité : ');

switch n
    case 1
        %Initialisation d'une matrice 3x3
        x = [1,1,0;
        0,0,1;
        0,1,0];

        %Création de la matrice A
            %Partie vertical
        A = [1,1,1,0,0,0,0,0,0;
            0,0,0,1,1,1,0,0,0;
            0,0,0,0,0,0,1,1,1;
            %Partie diagonale NE-SO
            1,0,0,0,0,0,0,0,0;
            0,1,0,1,0,0,0,0,0;
            0,0,1,0,1,0,1,0,0;
            0,0,0,0,0,1,0,1,0;
            0,0,0,0,0,0,0,0,1;
            %Partie diagonale NO-SE
            0,0,1,0,0,0,0,0,0;
            0,1,0,0,0,1,0,0,0;
            1,0,0,0,1,0,0,0,1;
            0,0,0,1,0,0,0,1,0;
            0,0,0,0,0,0,1,0,0;
            %Partie horizontale
            1,0,0,1,0,0,1,0,0;
            0,1,0,0,1,0,0,1,0;
            0,0,1,0,0,1,0,0,1];
        
        taille_x = 3;
        
    case 2
        %Cas d'une image 20x20

        x=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 1 0 0 0 0 1 0 0 0 0 0 1 1 0 0 0 0 0 0
            0 1 0 0 0 0 1 0 0 0 0 1 0 0 1 0 0 0 0 0
            0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0
            0 0 0 1 1 0 1 0 0 0 1 0 0 0 0 1 0 0 0 0
            0 0 0 0 0 0 0 1 0 1 0 1 0 0 1 0 0 0 0 0
            0 0 0 0 0 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0
            0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        s = size(x);
        taille_x = s(1,1);
        A = find_projection_matrix(taille_x);

end

%Création d'un vecteur contenant les valeurs de la matrice nxn
x1 = x(:);

%Calcul du USV de A
[U,S,V]=svd(A);

%Calcul de b = Ax
b = A*x1;

%Calcul de la petite perturbation aléatoire db
db = var*(0.5-rand(size(b)));

%Calcul du vecteur solution à partir de la méthode des moindres carrés
%(effet du "\" sur une matrice non carré)
x_mc = A\(b+db);

%Sinon, x_mc = A'*A\A'*(b+db);

switch n
    case 1
        %Passage de la matrice 9x1 en matrice 3x3
        X_mc = reshape(x_mc,[3,3]);

    case 2
        %Passage de la matrice trop longue en matrice 20x20
        X_mc = reshape(x_mc,size(x));
end

figure(1);
subplot(221);
imshow(x);
subplot(222);
imshow(X_mc);

%Calcul du système par la méthode de régularisation de Tikhonov
In = eye(size(A'*A));
x_tik = (A'*A+2*lambda*In)\A'*(b+db);

switch n
    case 1
        %Passage de la matrice 9x1 en matrice 3x3
        X_tik = reshape(x_tik,[3,3]);

    case 2
        %Passage de la matrice trop longue en matrice 20x20
        X_tik = reshape(x_tik,size(x));
end
        
subplot(223);
imshow(X_tik);

%Affichage des valeurs singulières de A
disp(diag(S));

%Test de l'efficacité de la solution proposé et correction
switch n
    case 1
        
    case 2
        %Passage de la matrice trop longue en matrice 20x20
        mse = norm(x-X_mc,'fro');
        disp(mse);
        
        mse2 = norm(x-X_tik,'fro')^2;
        disp(mse2);
        
        %Pasage par la régularisation de Tikhonov
        D = diag(S)./(diag(S).^2+lambda);
        r = length(D);
        D = diag(D);
        x_best_tik = V*D*U(:,1:r)'*(b+db);
        X_best_tik = reshape(x_best_tik,size(x));
        
        mse3 = norm(x-X_best_tik,'fro')^2;
        disp(mse3);
        
        subplot(224);
        imshow(X_best_tik);
end




