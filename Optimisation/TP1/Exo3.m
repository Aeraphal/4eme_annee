
%% Methode Analytique
clear variables;
close all;


%c=@(x)(sin(x));

f=@(x,H,z)(norm(H*x -z)^2);
df=@(x,H,z)(2*H'*(H*x-z));
fz=@(x,H,b)(H*x + b);


t=0:0.01:pi;
dim=length(t);
b=randn(dim,1);
x=sin(t)';
H=matH(size(x),'gaussian',3);
z=fz(x,H,b);

y=(H'*H)\H'*z;


figure(1)
hold on
plot(t,sin(t),'r')
plot(t,z,'k')
plot(t,y)
legend("sin(x)","signal bruité","Methode analytique")



%% Descente de gradient
eps= 10^-4;
delta=1;
lambda=0.5;

l=[f(x,H,z)];
compteur=0;

while delta> eps
    compteur=compteur+1;
    x1=x-lambda*df(x,H,z);
    delta=norm(df(x1,H,z));
    x=x1;
    l=[l;f(x,H,z)];
    
end

compteur


%a=f(x,H,z)
figure (2)
hold on
plot(l);
legend("Methode de la descente de gradiant")


figure(3)
hold on
plot(t,sin(t),'r');
plot(t,z,'k');
plot(t,y);
plot(t,z,'*');
legend("sin(x)","signal bruité","Methode analytique")

