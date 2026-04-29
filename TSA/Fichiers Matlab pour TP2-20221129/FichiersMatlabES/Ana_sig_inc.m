clear variables
close all

load sig s;

nd=1;
nf=1001;
NFFT=1024;
[Est1, vec_f1, N] = Estimateur_1(s,nd,nf,NFFT);

figure(1);
hold on;
semilogy(vec_f1,Est1);
%axis([0 1 10 10^7]);
title('Estimateur simple sur un signal à 1000 échantillons avec NFFT=1024');
legend('DSPM estimee');
xlabel('fréquence réduite');
ylabel('amplitude');


N=100000;
M=500;

[Est2, vec_f2] = Estimateur_2(s,N,M,NFFT);
figure (2)
hold on;
semilogy(vec_f2,Est2);
%axis([0 0.5 -50 10]);
legend('DSPM estimée');
title('Estimateur moyenné sur un signal à 100000 échantillons avec NFFT=1024');
legend('DSPM estimee');
xlabel('fréquence réduite');
ylabel('amplitude');

Nom_fenetre='blackman';
NOVERLAP=M/2;
[Est3,vec_f3] = Estimateur_3(s,N,Nom_fenetre,M,NOVERLAP,NFFT);

figure(3)
hold on;
semilogy(vec_f3,Est3);
legend('DSPM estimée');
title('Estimateur de Welch sur un signal à 100000 échantillons avec NFFT=1024');
legend('DSPM estimee');
xlabel('fréquence réduite');
ylabel('amplitude');

