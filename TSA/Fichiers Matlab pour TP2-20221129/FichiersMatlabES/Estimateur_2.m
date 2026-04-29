function [Est, vec_f]=Estimateur_2(brfil, N, M, NFFT)
    %Selection de la séquence à analyser
    aeser=brfil(1:N);
    
    %Calcul grâce à pwelch
    [Est, vec_f] = pwelch(aeser, rectwin(M),0,NFFT,1,'twosided');
end