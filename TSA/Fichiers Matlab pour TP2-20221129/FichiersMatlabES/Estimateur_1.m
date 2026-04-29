function [Est, vec_f, N]=Estimateur_1(brfil, nd, nf, NFFT)

    %Sélection de la séquence à analyser
    aest = brfil(nd:nf);
    %Calcul du nombre d'échantillons résultant N à analyser
    N = nf-nd+1;
    vec_f=0:1/NFFT:1-1/NFFT;
    %Calcul de l'estimation.
    Est = fft(aest,NFFT);
    Est = (abs(Est).^2)*(1/NFFT);
end