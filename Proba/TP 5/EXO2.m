%% Partie 1
clear variables;
close all;

k = 3:1:8;
P_k = [4/20,1/20,3/20,7/20,2/20,3/20];

%1)
Ex=sum(P_k.*k);
ecartt=(sum((k.^2).*P_k)-(Ex^2))^(1/2);


figure(1)

subplot(311) 
bar(k,P_k)   

legend('loi de X');
ylabel('P(X = k)');
xlabel('k (valeur de X)');
xlim([2 9]);
ylim([0 0.5]);

fprintf('===== Affichage =====\n');
disp(['esperance theorique : ',num2str(Ex)]);
disp(['ecart type theorique : ',num2str(ecartt)]);

%b)
k2 = 6:1:16;
convX=conv(P_k,P_k);

Ex2=sum(convX.*k2);
ecartt2=(sum((k2.^2).*convX)-(Ex2^2))^(1/2);

subplot(312) 
bar(k2,convX)   

legend('loi de X1 + X2 ');
ylabel('P(X1 + X2 = k)');
xlabel('k (valeur de X1 + X2 )');
xlim([5 17]);
ylim([0  0.2]);

fprintf('===== Affichage 2 =====\n');
disp(['esperance theorique : ',num2str(Ex2)]);
disp(['ecart type theorique : ',num2str(ecartt2)]);

%c)
n=10;

k3 = 3*n:1:8*n;
convX2=conv(P_k,P_k);

for i= 1:(n-2)
   convX2=conv(convX2,P_k);

end



Ex3=sum(convX2.*k3);
ecartt3=(sum((k3.^2).*convX2)-(Ex3^2))^(1/2);

subplot(313)
hold on 
bar(k3,convX2)   


ylabel('P(n*X = k)');
xlabel('k (valeur de n*X )');
xlim([(3*n)-1,(8*n)+1]);
ylim([0  0.1]);

fx=(1/(ecartt3*((2*pi)^(1/2))))* exp(-((k3-Ex3).^2)/(2* (ecartt3 .^2)));
plot(k3,fx);
legend('loi de n*X','densite limite (TCL)');
fprintf('===== Affichage   3=====\n');
disp(['esperance theorique : ',num2str(Ex3)]);
disp(['ecart type theorique : ',num2str(ecartt3)]);


 
