%% Methode Analytique
clear variables;
close all;

n=1;
%c=@(x)(sin(x));

f=@(x,H,z,lambda,Gamma)(norm(H*x -z)^2+lambda*norm(Gamma*x)^2);
df=@(x,H,z,lambda,Gamma)(2*H'*(H*x-z)+lambda*2*Gamma'*(Gamma*x));
fz=@(x,H,b)(H*x + b);

lambda = 0.2;
t=0:0.01:2*pi;
dim=length(t);

switch n
    case 0
        b=2*rand(dim,1)-1;
    case 1
        b=0.01*randn(dim,1);
end

x=sin(t)';
H=matH(size(x),'gaussian',3);

z=fz(x,H,b);

Gamma_i = matGamma(size(x),'identity');
Gamma_g = matGamma(size(x),'gradient');
Gamma_l = matGamma(size(x),'laplacian');
%% Méthode sans passer par la SVD de H

y_i=(H'*H+2*lambda*eye(dim))\H'*z;
y_g=(H'*H+2*lambda*(Gamma_g')*Gamma_g)\(H'*z);
y_l=(H'*H+2*lambda*(Gamma_l')*Gamma_l)\(H'*z);

figure(1)
hold on
plot(t,sin(t),'r')
%plot(t,z,'k*')
%plot(t,y_i)
plot(t,y_g);
%plot(t,y_l);
legend("sin(x)","gaussien")


%% Descente de gradient
eps= 10^-2;

%% Chez l'identité

x_i = x;
l_i=[f(x_i,H,z,lambda,Gamma_i)];
compteur_i=0;
delta=1;
while delta> eps
    compteur_i=compteur_i+1;
    x1=x_i-lambda*df(x_i,H,z,lambda,Gamma_i);
    delta=norm(df(x1,H,z,lambda,Gamma_i));
    x_i=x1;
    l_i=[l_i;f(x_i,H,z,lambda,Gamma_i)]; 
end
compteur_i;

%% Chez le gradient

x_g = x;
l_g=[f(x_g,H,z,lambda,Gamma_g)];
compteur_g=0;
delta=1;
while delta> eps
    compteur_g=compteur_g+1;
    x1=x_g-lambda*df(x_g,H,z,lambda,Gamma_g);
    delta=norm(df(x1,H,z,lambda,Gamma_g));
    x_g=x1;
    l_g=[l_g;f(x_g,H,z,lambda,Gamma_g)]; 
end
compteur_g;

%% Chez le laplacien

x_l = x;
l_l=[f(x_l,H,z,lambda,Gamma_l)];
compteur_l=0;
delta=1;
while delta> eps
    compteur_l=compteur_l+1;
    x1=x_l-lambda*df(x_l,H,z,lambda,Gamma_l);
    delta=norm(df(x1,H,z,lambda,Gamma_l));
    x_l=x1;
    l_l=[l_l;f(x_l,H,z,lambda,Gamma_l)]; 
end
compteur_l;

%% Affichage avancé du gradient

%a=f(x,H,z)
figure (2)
hold on
plot(l_i,'o');
plot(l_g,'o');
plot(l_l,'o');
legend("identité","gradient","laplacien");


figure(3)
hold on
plot(t,sin(t),'r');
plot(t,z,'k');
%plot(t,y_i,'b');
plot(t,y_g,'c');
%plot(t,y_l);
legend("sin(x)","signal bruité","gradient")