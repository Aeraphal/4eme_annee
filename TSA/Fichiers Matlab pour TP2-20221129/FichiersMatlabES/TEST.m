close all;
clear variables;

x = genbrfil();

[Est, vec_f, N]=Estimateur_1(x, 2000, 5000, 4096);
[Gth,Gbiais,fth]=sptheo(N,'simple');

figure(1);
hold on;
plot(vec_f,10*log10(Est));
plot(fth,Gth);
plot(fth,Gbiais);
xlim([0 0.5]);
ylim([-50 10]);
title(['L''estimation calculée avec N = ', num2str(N)]);
ylabel('Densité spectrale de puissance moyenne');
xlabel('fréquence');



figure(2);

for i = 1:1:9
    nd = 1;
    nf = 100*i^2;
    NFFT = 2;
    while NFFT<nf-nd+1
        NFFT = NFFT*2;
    end
    [Est, vec_f, N]=Estimateur_1(x, nd, nf, NFFT);
    [Gth,Gbiais,fth]=sptheo(N,'simple');
    
    subplot(3,3,i);
    hold on;
    plot(vec_f,10*log10(Est));
    plot(fth,Gth);
    plot(fth,Gbiais);
    xlim([0 0.5]);
    ylim([-50 10]);
    title(['L''estimation calculée avec N = ', num2str(N)]);
    ylabel(['DSPM avec NFFT : ', num2str(NFFT)]);
    xlabel('fréquence');
end


figure(3);

for i = 1:1:6
    nd = 1+(i-1)^2*2000;
    nf = 1001+(i-1)^2*2000;
    NFFT = 2;
    while NFFT<nf-nd+1
        NFFT = NFFT*2;
    end
    [Est, vec_f, N]=Estimateur_1(x, nd, nf, NFFT);
    [Gth,Gbiais,fth]=sptheo(N,'simple');
    
    subplot(2,3,i);
    hold on;
    plot(vec_f,10*log10(Est));
    plot(fth,Gth);
    plot(fth,Gbiais);
    xlim([0 0.5]);
    ylim([-50 10]);
    title(['L''estimation calculée entre ', num2str(nd),' et ', num2str(nf)]);
    ylabel(['DSPM avec NFFT : ', num2str(NFFT)]);
    xlabel('fréquence');
end


figure(4);

for i = 1:1:6
    nd = 1000;
    nf = 5000;
    NFFT = 2^8*2^i;
    [Est, vec_f, N]=Estimateur_1(x, nd, nf, NFFT);
    [Gth,Gbiais,fth]=sptheo(N,'simple');
    
    subplot(2,3,i);
    hold on;
    plot(vec_f,10*log10(Est));
    plot(fth,Gth);
    plot(fth,Gbiais);
    xlim([0 0.5]);
    ylim([-60 10]);
    title('L''estimation calculée avec N = 4001');
    legend(['NFFT = ', num2str(NFFT)]);
    ylabel('DSPM');
    xlabel('fréquence');
end

figure(5)
N=10000;
M=5000;
NFFT = 4096;
[Est, vec_f]=Estimateur_2(x, N, M, NFFT);
[Gth,Gbiais,fth]=sptheo(M,'moyenne');

hold on;
plot(vec_f,10*log10(Est));
plot(fth,Gth);
plot(fth,Gbiais);
xlim([0 0.5]);
ylim([-50 10]);
title(['L''estimation calculée avec N = ', num2str(N)]);
ylabel('Densité spectrale de puissance moyenne');
xlabel('fréquence');

% fenetre();
% 
figure(6)
N=10000;

Liste_nom = ['rectwin', 'bartlett', 'hann', 'hamming', 'blackman', 'gausswin'];
Liste_index = [1,8,16,20,27,35,43];

M=5000;
NOVERLAP=0;
NFFT = 4096;
for i=1:1:6

    Nom_fenetre = Liste_nom(Liste_index(i):Liste_index(i+1)-1);
    
    [Est, vec_f]=Estimateur_3(x,N,Nom_fenetre,M,NOVERLAP,NFFT);
    [Gth,Gbiais,fth]=sptheo(M,'moyenne');
    subplot(2,3,i);
    hold on;
    plot(vec_f,10*log10(Est));
    plot(fth,Gth);
    plot(fth,Gbiais);
    xlim([0 1]);
    ylim([-200 10]);
    title(['L''estimation calculée avec ', Nom_fenetre]);
    ylabel('Densité spectrale de puissance moyenne');
    xlabel('fréquence');
end



figure(7)

NOVERLAP= M/4;
for i=1:1:3

    Nom_fenetre = 'rectwin';
    
    [Est, vec_f]=Estimateur_3(x,N,Nom_fenetre,M,NOVERLAP*i,NFFT);
    [Gth,Gbiais,fth]=sptheo(M,'moyenne');
    subplot(1,3,i);
    hold on;
    plot(vec_f,10*log10(Est));
    plot(fth,Gth);
    plot(fth,Gbiais);
    xlim([0 0.5]);
    ylim([-100 10]);
    title(['L''estimation avec un recouvrement de ', num2str(NOVERLAP*i/M*100),'%']);
    ylabel('Densité spectrale de puissance moyenne');
    xlabel('fréquence');
end





