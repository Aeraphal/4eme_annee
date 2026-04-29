close all;
clear variables;
clc;

tmin = -5; tmax = 5; Te = 0.01;
t = tmin:Te:tmax;
N = length(t);
nu1 = 20;
nu2 = 45;
fonction = 2;

switch fonction
    case 1
        f_0 = exp(-5*pi*(t-1).^2);
        f_1 = 0.05*sin(2*pi*nu1*t)+0.02*sin(2*pi*nu2*t);

    case 2
        f_0 = triangle(t);
        f_1 = 0.05*cos(2*pi*nu1*t)+0.02*cos(2*pi*nu2*t);
end


        
        
f = f_0 + f_1;
subplot(2,3,1)
plot(t,f,'k')

% Nombre complexe
i=complex(0,1);

% intervalle fréquentiel 
nu_e=1/Te; 
nu=linspace(-nu_e/2,nu_e/2,N); 

% transformée de Fourier (initialisation) 
tf = zeros(0,N);

% calcul de la transformée de Fourier (utiliser commande trapz) 
for k=1:N % pour chaque fréquence  
    tf(k)=trapz(t,f.*exp(-2*i*pi*nu(k)*t)); 
end 

subplot(2,3,2);
plot(nu,real(tf),'r');xlim([-nu_e/2,nu_e/2]); 
subplot(2,3,3);plot(nu,imag(tf),'b');xlim([-nu_e/2,nu_e/2]); 

question = 1;
switch question
    case 1
        nu_case = 1/80;
       
    case 2
        nu_case = 1/30;
end

filtre = porte(nu_case*nu);
tff = tf.*filtre;
tff_inv = zeros(1,N);

for k=1:N
    tff_inv(k)=trapz(nu,tff.*exp(2*i*pi*nu*t(k)));
end

subplot(2,3,4);plot(t,tff_inv,'k');xlim([tmin,tmax]);
subplot(2,3,5);plot(nu,real(tff),'r');xlim([-nu_e/2,nu_e/2]); 
subplot(2,3,6);plot(nu,imag(tff),'b');xlim([-nu_e/2,nu_e/2]);







