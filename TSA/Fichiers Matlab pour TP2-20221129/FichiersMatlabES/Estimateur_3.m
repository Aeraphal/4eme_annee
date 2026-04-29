function [Est, vec_f]=Estimateur_3(brfil,N,Nom_fenetre,M,NOVERLAP,NFFT)
    %Selection de la séquence à analyser
    aeser=brfil(1:N);
    %Calcul grâce à pwelch
    eval(['WIN=', Nom_fenetre, '(M)']);
    [Est, vec_f] = pwelch(aeser, WIN,NOVERLAP,NFFT,1,'twosided');
end