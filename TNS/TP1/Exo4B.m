clear;
close all; 
clc 

Te=0.01;
t=-6:Te:6;
i=complex(0,1);
N=length(t); 

f = porte(t);
g = porte(t);

% intervalle fréquentiel 
nu_e=1/Te; 
nu=linspace(-nu_e/2,nu_e/2,N); 


% transformée de Fourier (initialisation) 
tff = zeros(1,N);
tfg = zeros(1,N);
h = zeros(1,N);

% calcul de la transformée de Fourier (utiliser commande trapz) 
for k=1:N % pour chaque fréquence  
    tff(k)=trapz(t,f.*exp(-2*i*pi*nu(k)*t));
    tfg(k)=trapz(t,g.*exp(-2*i*pi*nu(k)*t));
end 
p=tff.*tfg
for k=1:N
    h(k)=trapz(nu,p.*exp(2*pi*nu*t(k)));
end
subplot(2,2,1);plot(t,f,'.r'); 
subplot(2,2,2); plot(t,g,'.b'); 
subplot(2,2,[3,4]);plot(t,real(h),'.k');