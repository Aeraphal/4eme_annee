clear variables;  % efface les variables 
close all;        % ferme toutes les fenêtres 
clc;              % efface le contenu de la zone de commande  
 
u=[2,-1,3,7,1];   % vecteur ligne 
v=[1,4,-3,8,2];   % vecteur ligne (de même dimension que u) 
[ps,pm1,pm2]= MyFunction(u,v); % appel de la fonction MyFunction 
 
disp('Produit scalaire :');disp(ps); 
disp('Produit matriciel 1 :');disp(pm1); 
disp('Produit matriciel 2 :');disp(pm2);