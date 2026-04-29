clear variables;close all;hold on;
n=5; % nombre de points
x = -3 + 8 *rand(1,n); % abscisses (vecteur ligne)
y= -4 + 7 *rand(1,n); % ordonnées (vecteur ligne)

plot(x,y,'ok'); % matrice 2xn (concaténation de x et y)

U= [x;y]; % matrice 2xn (concaténation de x et y)
% droite d'équation y=0.5*x
t=-4:0.001:6; % abscisses
z=t/2; % ordonnées
plot(t,t/2,'k'); % affichage de la droite (trait continu)
% propriétés du repère
axis([-3,5,-4,3]);
grid on;
axis('equal');
% vecteur directeur de la droite
N= [2;1];
N = N/norm(N);
% matrice de projections sur la droite
P= N*N';

% initialisation de la matrice 2xn contenant les abscisses (1ère ligne)
% et les ordonnées (2ème ligne) des points projetés sur la droite
V=zeros(2,n);
% calcul des coordonnées des points projetés (BOUCLE FOR OBLIGATOIRE)
for k=1:n
V(:,k) = P*U(:,k);
end
% affichage des points projetés (étoiles)
plot(V(1,:),V(2,:),'*k');
% on relie les points initiaux à leurs projections
for k=1:n
plot([U(1,k), V(1,k)],[U(2,k), V(2,k)],'k');
end
% on perturbe les coordonnées des points projetés
delta=0.8;
dV=-delta/2+delta*rand(2,n);
W=V+dV;
% affichage des points perturbés (triangles)
plot(W(1,:),W(2,:),'vk');
% calcul de la droite passant au plus près des points perturbés (résolution
% au sens des moindre carrés d’un système Au=v, avec A et v à définir)
A = zeros(n,2);
for k=1:n
    A(k,:) =[1 W(1,k)];
end 

v= W(2,:)';
u=A\v;
u = u'
% affichage de la droite (en pointillés)
f = u(1)+ u(2)*t 
plot(t,f,'k--');


