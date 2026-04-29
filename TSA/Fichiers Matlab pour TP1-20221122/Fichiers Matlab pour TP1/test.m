close all;
clear variables;
Fs=1000;
N=10000;
B= 100;
m3=5;
ecart3 = 2;
[x_1, x_2, x_3, a, b] = Filtre_PB(N,B,m3,ecart3);
[Gain,freq]=freqz(b,a,N,Fs);
calc_hist(x_3);
tk=Fs*(0:1:N-1);

figure (3)
subplot(241);
plot(tk,x_1);
subplot(242);
plot(tk,x_2);
subplot(243);
plot(tk,x_3);
subplot(244);
plot(freq,abs(Gain));
    

subplot(245);
[prob_est1, Cic1]=calc_hist(x_1);
y1=(1/(2*pi)^(1/2)).*exp((-(Cic1.^2)/2));
plot(Cic1,y1);
disp(std(Cic1));

x2=-1:0.01:1.5;
subplot(246);
[prob_est2, Cic2]=calc_hist(x_2);
y2=(1/(std(x_2)*((2*pi)^(1/2)))).*exp((-(((Cic2-mean(x_2))/std(x_2)).^2)/2));
plot(Cic2,y2);
disp(std(Cic2));

x3=-1:0.01:11;
subplot(247);
[prob_est3, Cic3]=calc_hist(x_3);
y3=(1/(std(x_3)*(2*pi)^(1/2))).*exp((-(((Cic3-mean(x_3))/std(x_3)).^2)/2));
plot(Cic3,y3);
disp(std(Cic3));;


figure(4);

for i = 1:1:8
    N = 2^(3+i);
    [x_1, x_2, x_3, a, b] = Filtre_PB(N,B,m3,ecart3);
    subplot(2,4,i);
    [prob_est1, Cic1]=calc_hist(x_1);
    y1=(1/(2*pi)^(1/2)).*exp((-(Cic1.^2)/2));
    plot(Cic1,y1);

end


figure(5);
N=1000;
[x_1, x_2, x_3, a, b] = Filtre_PB(N,B,m3,ecart3);
subplot(1,3,1);
[prob_est1, Cic1]=calc_hist(x_1,N);
y1=(1/(2*pi)^(1/2)).*exp((-(Cic1.^2)/2));
plot(Cic1,y1);
subplot(1,3,2);
[prob_est1, Cic1]=calc_hist(x_1,2);
y1=(1/(2*pi)^(1/2)).*exp((-(Cic1.^2)/2));
plot(Cic1,y1);
subplot(1,3,3);
[prob_est1, Cic1]=calc_hist(x_1);
y1=(1/(2*pi)^(1/2)).*exp((-(Cic1.^2)/2));
plot(Cic1,y1);


figure(6)


Fs=1000;
N=100000;
B= 5;
m3=5;
ecart3 = 2;
[x_1, x_2, x_3, a, b] = Filtre_PB(N,B,m3,ecart3);
[Gain,freq]=freqz(b,a,N,Fs);
calc_hist(x_3);
tk=Fs*(0:1:N-1);

subplot(241);
plot(tk,x_1);
subplot(242);
plot(tk,x_2);
subplot(243);
plot(tk,x_3);
subplot(244);
plot(freq,abs(Gain));
    

subplot(245);
[prob_est1, Cic1]=calc_hist(x_1);
y1=(1/(2*pi)^(1/2)).*exp((-(Cic1.^2)/2));
plot(Cic1,y1);


x2=-1:0.01:1.5;
subplot(246);
[prob_est2, Cic2]=calc_hist(x_2);
y2=(1/(std(x_2)*((2*pi)^(1/2)))).*exp((-(((Cic2-mean(x_2))/std(x_2)).^2)/2));
plot(Cic2,y2);

x3=-1:0.01:11;
subplot(247);
[prob_est3, Cic3]=calc_hist(x_3);
y3=(1/(std(x_3)*(2*pi)^(1/2))).*exp((-(((Cic3-mean(x_3))/std(x_3)).^2)/2));
plot(Cic3,y3);


Kurtoffel = kurtosis(x_2);
disp(Kurtoffel);













