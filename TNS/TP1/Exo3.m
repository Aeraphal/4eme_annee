clear variables;
close all; 
% intervalle temporel 
tmin=-5;tmax=5;Te=0.01; 
t=tmin:Te:tmax; 
N=length(t); 
  
% lorentzienne 
f0=(1+(t+1).^2).^(-1); 
 
% signal bruité (bruit gaussien) 
f=f0+0.05*randn(1,N);  
  
% affichage 
figure(1);hold on; 
plot(t,f); 
xlabel('temps $(t)$','interpreter','latex');

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

% Restriction de la transformée de Fourier à 2,5Hz
tf2 = tf.*porte(nu/5);

% affichage 
figure(1); 
subplot(311);plot(nu,real(tf2),'k');xlim([-10,10]); 
subplot(312);plot(nu,imag(tf2),'k');xlim([-10,10]); 

tf_inv = zeros(1,N);
for k=1:N
    tf_inv(k)=trapz(t,tf2.*exp(2*i*pi*nu.*t(k)));
end

subplot(313);plot(nu,tf_inv,'k');xlim([-10,10]); 

