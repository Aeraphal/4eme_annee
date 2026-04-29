function [x_1, x_2, x_3, a, b] = Filtre_PB(N,B,m3,ecart3)
    x_1 = randn(1,N);
    Fs = 1000;
    Wn = B*2/Fs;
    m = 8;
    [b, a] = butter(m, Wn);
    %freqz(b,a,N,Fs);
    
    x_2 = filter(b,a,x_1);
    m_2 = mean(x_2);
    ecart2 = std(x_2);
    x_3 = (x_2-m_2)/ecart2*ecart3+m3;
end