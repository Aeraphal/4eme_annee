close all;
clear variables;

[s,Fs] = audioread('ProtestMonoBruit.wav');
sound(s,Fs);
taille = length(s)-1;
temps = 0:taille;
temps = temps/Fs;
figure(1);
plot(temps,s);
xlabel('Temps');
ylabel('Amplitude');
title('Signal échantillonnée');

new_s = s(60*Fs : 70*Fs);
K = 200;

[R,lags] = xcorr(new_s, K, 'biased');

figure(2);
plot(lags,R);
xlabel('Temps entre 60s et 70s');
ylabel('Amplitude');
title('Autocorrélation du Signal');


M = 20;
[R,lags] = xcorr(new_s, M, 'biased');

lags1 = lags(M+1:end);

T = toeplitz(R(M+1:end));
T = pinv(T);
Choix = zeros(M+1,1);
Choix(1,1) = 1;
H = T*Choix;
Sigma = sqrt(1/H(1));

H = -Sigma^2*H;

figure(3);
stem(lags1(2:end), H(2:end));


%p = conv(s,h);
%p=(0 p(1:end-1))
prediction=zeros(length(new_s)-1,1);

for i=1:length(new_s)-1
    for k = 1:M
        prediction(i+1) = prediction(i+1) +  H(k+1)*s(60*Fs+i-k);
    end    
end 

new_t = 1:length(new_s);


figure(4);
subplot(211);
plot(new_t, prediction);
title('Prédiction du signal');

subplot(212);
plot(new_t, abs(new_s - prediction));
title('Valeur absolue de l''erreur de prédiction');

figure(5);

subplot(211);
plot(new_t, new_s);

subplot(212);
plot(new_t, prediction);

seuil=zeros(length(new_s),1); %initialisation matrice
for i=1:length(new_s)
    if (prediction(i,1)>0.17) %si depassement seuil 0.17
        seuil(i,1)=1; %on met 1 dans matrice
    else
        seuil(i,1)=-1; %sinon 0
    end
end






