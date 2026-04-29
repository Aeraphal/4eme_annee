clear variables;
close all;
%% Partie 1
clear variables;
close all;

nbr_boules = input('Combien y a-t-il de boules ?');
nbr_tirages = input('Combien y a-t-il de tirages ?');
tirages = zeros(1,nbr_tirages) ;

Ex = (nbr_boules +1)/3;
Vx = (nbr_boules^2 -nbr_boules-2)/18;
ecartt=Vx^(1/2);

k = linspace(1,nbr_boules,nbr_boules);

k2=[1;2;3;4;5;6;7;8];
Px=2*(nbr_boules-k)/(nbr_boules*(nbr_boules-1));



for i = 1:nbr_tirages
    tirage = ProbaDiscrete(nbr_boules);
    tirages(i) = tirage;
    
end

figure(1);
hold on;
htirages=histogram(tirages,'Normalization','probability');

hX=bar(k,Px,'r'); 
xlabel('K');
ylabel('P(X=K)');
title('Histogramme des probabilites')
legend('Empirique','théorique');

Ex2=mean(tirages);
ecart=std(tirages);

fprintf('===== Affichage =====\n');
disp(['esperance theorique : ',num2str(Ex)]);
disp(['esperance empirique : ',num2str(Ex2)]);
disp(['ecart type theorique : ',num2str(ecartt)]);
disp(['ecart type empirique : ',num2str(ecart)]);



