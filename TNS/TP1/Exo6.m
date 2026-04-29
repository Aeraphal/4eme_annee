close all;
clear variables;
clc;

Part = 2;
question = 2;
switch Part
    
    case 1
        tmin = -5;
        tmax = 5;

        switch question
            case 1
                Te = 0.005;
                t = tmin:Te:tmax;
                N = length(t);
                k1 = 2;
                k2 = 4;
                k3 = 6;

                sigma_1 = 1/2^k1;
                sigma_2 = 1/2^k2;
                sigma_3 = 1/2^k3;

                g_sigma_1 = exp(-t.^2/(2*sigma_1^2))/(sigma_1*sqrt(2*pi));
                g_sigma_2 = exp(-t.^2/(2*sigma_2^2))/(sigma_2*sqrt(2*pi));
                g_sigma_3 = exp(-t.^2/(2*sigma_3^2))/(sigma_3*sqrt(2*pi));

                subplot(2,3,1); plot(t,g_sigma_1,'m'); grid on;
                subplot(2,3,2); plot(t,g_sigma_2,'r'); grid on;
                subplot(2,3,3); plot(t,g_sigma_3,'g'); grid on;

            case 2
                Te = 0.025;
                t = tmin*2:Te:tmax*2;
                N = length(t);
                g_sigma_1 = porte(2*t);
                g_sigma_2 = porte(t/2);
                g_sigma_3 = porte(t/4);

                subplot(2,3,1); plot(t,g_sigma_1,'.m'); grid on;
                subplot(2,3,2); plot(t,g_sigma_2,'.r'); grid on;
                subplot(2,3,3); plot(t,g_sigma_3,'.g'); grid on;
        end





        % Nombre complexe
        i=complex(0,1);

        % intervalle fréquentiel 
        nu_e=1/Te; 
        nu=linspace(-nu_e/4,nu_e/4,N); 

        % transformée de Fourier (initialisation) 
        tf_1 = zeros(0,N);
        tf_2 = zeros(0,N);
        tf_3 = zeros(0,N);

        % calcul de la transformée de Fourier (utiliser commande trapz) 
        for k=1:N % pour chaque fréquence  
            tf_1(k)=trapz(t,g_sigma_1.*exp(-2*i*pi*nu(k)*t)); 
            tf_2(k)=trapz(t,g_sigma_2.*exp(-2*i*pi*nu(k)*t)); 
            tf_3(k)=trapz(t,g_sigma_3.*exp(-2*i*pi*nu(k)*t)); 
        end 

        subplot(2,3,4); plot(nu,tf_1,'m'); grid on;
        subplot(2,3,5); plot(nu,tf_2,'r'); grid on;
        subplot(2,3,6); plot(nu,tf_3,'g'); grid on;
        
        
        
    case 2
        

        tmin = -4;
        tmax = 4;

        Te = 0.005;
        t = tmin:Te:tmax;
        N = length(t);
        nu0 = 5;
        s = exp(-pi*t.^2).*cos(2*pi*nu0*t);

        subplot(1,2,1); plot(t,s,'k');
        % Nombre complexe
        i=complex(0,1);

        % intervalle fréquentiel 
        nu_e=1/Te; 
        nu=linspace(-nu_e/4,nu_e/4,N); 

        tf = zeros(1,N);
        for k=1:N % pour chaque fréquence  
            tf(k)=trapz(t,s.*exp(-2*i*pi*nu(k)*t));
        end
        switch question
            case 1
                subplot(1,2,1); plot(t,s,'k');xlim([-20,20]);
                subplot(1,2,2); plot(nu,real(tf),'k');xlim([-20,20]);
                
                
            case 2
                
                k1 = 2;
                k2 = 4;
                k3 = 6;

                sigma_1 = 1/2^k1;
                sigma_2 = 1/2^k2;
                sigma_3 = 1/2^k3;

                g_sigma_1 = exp(-t.^2/(2*sigma_1^2))/(sigma_1*sqrt(2*pi));
                g_sigma_2 = exp(-t.^2/(2*sigma_2^2))/(sigma_2*sqrt(2*pi));
                g_sigma_3 = exp(-t.^2/(2*sigma_3^2))/(sigma_3*sqrt(2*pi));
                
                y1 = conv(s,g_sigma_1,'same')/Te; y1 = y1/max(y1);
                y2 = conv(s,g_sigma_2,'same')/Te; y2 = y2/max(y2);
                y3 = conv(s,g_sigma_3,'same')/Te; y3 = y3/max(y3);
                s = s/max(s);
                
                subplot(3,1,1); plot(t,s,'k'); hold on; plot(t,y1,'m'); grid on;
                subplot(3,1,2); plot(t,s,'k'); hold on; plot(t,y2,'r'); grid on;
                subplot(3,1,3); plot(t,s,'k'); hold on; plot(t,y3,'g'); grid on;

        end
end













