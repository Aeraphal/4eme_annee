close all
clear variables
clc

question = 2;

i = complex(0,1);
D = 1;
N = 2^12;
dt = 2*D/N;
t = -D:dt:D-dt;

% intervalle fréquentiel 
nu_e=1/dt; 
nu=linspace(-nu_e/2,nu_e/2,N); 

T1 = 2^(-5);
T2 = 2^(-6);
p_1 = peigne(T1,t);
p_2 = peigne(T2,t);
tf1 = TransFourier(p_1,t);
tf2 = TransFourier(p_2,t);

vo = 5;
s = exp(-pi*t.^2).*cos(2*pi*vo*t);

z = s.*p_2;
tfs = TransFourier(s,t);
tfz = TransFourier(z,t);





switch question
    case 1
        subplot(2,2,1); plot(t,p_1,'b');
        subplot(2,2,2); plot(nu,tf1,'b');
        subplot(2,2,3); plot(t,p_2,'b');
        subplot(2,2,4); plot(nu,tf2,'b');
        
    case 2
        
        subplot(3,1,1); plot(t,s,'r'); hold on; plot(t,z,'.r');
        subplot(3,1,2); plot(nu,tfs,'k'); xlim([-50,50]);
        subplot(3,1,3); plot(nu,tfz,'r');xlim([-500,500])
        
        
end