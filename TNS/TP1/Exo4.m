clear variables;
close all; 
clc

Te=0.01;
t=-10:Te:10;
i=complex(0,1);
N=length(t); 


%Choix de la question choisis
question=2;
cas=1;



switch cas
    case 1
 %Partie A, premier cas
        f1 = porte(t);
        f2 = porte(t);
    case 2
 %Partie A, deuxième cas
        f1=2*porte((t-1)/2);
        f2=porte(t-0.5);
    case 3
 %Partie A, troisième cas
        f1=porte((t-1)/4);
        f2=t/2.*porte((t-1)/2);
    case 4
 %Partie A, quatrième cas
        a=rand;
        f1=exp(-a*t.^2/2);
        b=rand;
        f2=exp(-b*t.^2/2);
end

switch question
    case 1
    
        subplot(2,2,1);plot(t,f1,'.r'); grid on; 
        subplot(2,2,2); plot(t,f2,'.b'); grid on; 

        f3=conv(f1,f2,'same');
        f3=f3*Te;

        subplot (2,2,[3,4]);
        plot(t,f3,'.k'); grid on; 

% Partie B!

    case 2

        % intervalle fréquentiel 
        nu_e=1/Te; 
        nu=linspace(-nu_e/2,nu_e/2,N); 

        % transformée de Fourier (initialisation) 
        tff = zeros(1,N);
        tfg = zeros(1,N);
        h = zeros(1,N);

        % calcul de la transformée de Fourier (utiliser commande trapz) 
        for k=1:N % pour chaque fréquence  
            tff(k)=trapz(t,f1.*exp(-2*i*pi*nu(k)*t));
            tfg(k)=trapz(t,f2.*exp(-2*i*pi*nu(k)*t));
        end 
        p=tfg.*tff;

        for k=1:N
            h(k)=trapz(nu,p.*exp(2*i*pi*nu*t(k)));
        end
        subplot(2,2,1);plot(t,f1,'.r'); 
        subplot(2,2,2); plot(t,f2,'.b'); 
        subplot (2,2,[3,4]);plot(t,real(h),'.k');
        
        
end








