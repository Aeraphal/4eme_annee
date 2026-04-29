%% Partie 1
clear variables;
close all;
a=-11;
b=18;
n=50000;
Ext=4;
ecarttt=3;

pas = 1/n;
k= a:pas:b;
k2=-5:pas:5;


R=(-2*log(rand(1,n))).^(1/2);
R2 =-2*log(rand(1,n));
teta = 2* pi * rand(1,n);
X = R .* cos(teta);
Y = R .* sin(teta);

fxn=(1/(1*((2*pi)^(1/2))))* exp(-((k2-0).^2)/(2* (1 .^2)));

figure(1)
subplot(211)

hold on
hist1 = histogram(X,'Normalization','pdf'); 

ylabel('P(X = k)');
xlabel('k (valeur de X )');


fprintf('===== Affichage  1 =====\n');

Ex=mean(X);
ecartt=std(X);
disp(['esperance empirique : ',num2str(Ex)]);
disp(['ecart type empirique : ',num2str(ecartt)]);


plot(k2,fxn);
legend('densite simule','loi normal centre reduite');

subplot(212)
hold on
hist2 = histogram(Y,'Normalization','pdf');  

ylabel('P(Y = k)');
xlabel('k (valeur de Y )');

legend('densite simule');
fprintf('===== Affichage  2 =====\n');

Ex=mean(Y);
ecartt=std(Y);

disp(['esperance empirique : ',num2str(Ex)]);
disp(['ecart type empirique : ',num2str(ecartt)]);


plot(k2,fxn);
legend('densite simule','loi normal centre reduite');

figure(2)

P_k = Ext + ecarttt.*(X) ;
hold on 

hist3 = histogram(P_k,'Normalization','pdf');  


ylabel('f(x)');
xlabel('x');

xlim([(Ext -5*ecarttt) (Ext + 5*ecarttt) ]);
ylim([0  1/ecarttt]);

fx=(1/(ecarttt*((2*pi)^(1/2))))* exp(-((k-Ext).^2)/(2* (ecarttt .^2)));


Ex=mean(P_k);
ecartt=std(P_k);

plot(k,fx);

legend('densite simule','densite theorique ');
fprintf('===== Affichage   =====\n');
disp(['esperance theorique : ',num2str(Ext)]);
disp(['esperance empirique : ',num2str(Ex)]);
disp(['ecart type theorique : ',num2str(ecarttt)]);
disp(['ecart type empirique : ',num2str(ecartt)]);
