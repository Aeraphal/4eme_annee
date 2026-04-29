%chargement des signaux
load Ex2_signaux;
Y=D;
[n,m]=size(Y); % n=768 abscisses, m=20 signaux
% affichage des 20 signaux
figure(1);
for i=1:m
subplot(m,1,i);
title('Signaux originaux','interpreter','latex');
plot(Y(:,i));
axis off;
end