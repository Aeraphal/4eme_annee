close all;
clear variables;

%% Partie 1

x = -5:1/100:5;
y = abs(x);
figure(1);
hold on;
plot(x,y);
f = @(x)(abs(x));
df = @(x,c)(x==0).*c+(~(x==0)).*(sign(x));


eps = 0.1;
delta = 1;
lambda = 0.2;
compteur = 0;
x1 = 4;
l_x = []; 
l_y = [];
c = -1;

while delta>eps && compteur<200
    x1 = x1 - lambda * df(x1,c);
    l_x = [l_x,x1];
    y1 = abs(x1);
    l_y = [l_y,y1];
    delta = norm(df(x1,c));
    compteur = compteur + 1;
end
t = -5:lambda:-5+lambda*(compteur-1);
plot(l_y,l_x,'o');

gamma = 0.7;

t = -50:0.1:50;
a = 5;
b = 2;

f = @(x,a,b) abs(a*x + b);
M=@(x,a,b,gamma) (  (x>-b/a + a*gamma).*(a*x+b -a^2*gamma/2)...
                   +(x<-b/a - a*gamma).*(-a*x-b - a^2*gamma/2) ...
                   +((x<=-b/a + a*gamma) & (x>=-b/a - a*gamma)).*(1/(2*gamma)*((x+b/a).^2))  );

figure(2);
hold on;
Super = f(t,a,b);
Moreau = M(t,a,b,gamma);
plot(t,Super);
plot(t,Moreau);

g = @(x,z)((x-z).^2); % (.-z)^2
dg = @(x,z)(2*x.*(x-z));

h = @(x,l)(l*abs(x)); % Lambda * |.|
dh = @(x,c,l)(x==0).*c*l+(~(x==0)).*(l*sign(x));


prox1=@(x,z,gamma)((-2*z*gamma+x)/(2*gamma+1));
prox=@(x,lambda,gamma)(((x>lambda*gamma)).*(x-lambda*gamma)+...
    (x<-lambda*gamma).*(x+lambda*gamma) +...
    (x<=lambda*gamma |x>=-lambda*gamma).*(0));

gamma = 0.1;
lambda = 1;
z = 10;

figure(3);
subplot(211);
hold on;
Super2 = g(x,z);
Moreau2 = prox1(x,z,lambda);
plot(x,Super2);
plot(x,Moreau2);   
title('(.-z)^2');

subplot(212);
hold on;
Super3 = h(x,lambda);
Moreau3 = prox(x,lambda,gamma);
plot(x,Super3);
plot(x,Moreau3);   
title('lambda*|.|');

%% Partie 2



eps= 10^-4;
delta=1;
% On utilise prox déjà codé
lambda=1;
gamma=0.1;
x=2;
xi=[x];
l=[abs(x)];
compteur=0;

while delta> eps && compteur<500
    compteur=compteur+1;
    x1=prox(x,lambda,gamma);
    xi=[xi,x1];
    delta=norm(df(x1,c));
    x=x1;
    l=[l;abs(x)];
   
end
figure(5)
hold on
plot(-3:0.1:3,abs(-3:0.1:3))
plot(xi,l,'*-')
title('Algorithme du point proximal')
disp(x1)



y=2;
lambda = 2;
yi=[y];
ly=[y^2+lambda*abs(y)];
compteur=0;



while delta> eps && compteur<500
    compteur=compteur+1;
    %Descente de gradient sur f
    zi = y - gamma * 2 * y;
    %point proximal sur g
    y1=prox(zi,lambda,gamma);
    yi=[yi,y1];
    delta=norm(df(y1,c)+2*y);
    y=y1;
    ly=[ly;abs(y)];
   
end
figure(6)
hold on
plot(-3:0.1:3,abs(-3:0.1:3))
plot(yi,ly,'*-')
title('Algorithme du point proximal')
disp(y1)

eps = 0.00001;
dim = 3;
gamma = 0.01;
x = 4*rand(1,dim)-2;
yi=[y];
ly=[norm(x,1)];
compteur=1;

f1 = @(x)(norm(x,2)^2);
df1 = @(x)(2*x);

while delta> eps && compteur<500
    compteur=compteur+1;
    %Descente de gradient sur f
    zi = y - gamma * df1(y); 
    %point proximal sur g
    y1=prox(zi, lambda, gamma);
    yi=[yi,y1];
    delta=norm(yi(compteur)-yi(compteur-1));
    y=y1;
    ly=[ly;norm(y,1)];
   
end
figure(7)
hold on
plot(ly)
title('Fonction de coût')
disp(y1)

%% Partie 3
clear variables;
close all;

% Methode Analytique
clear variables;
close all;

%c=@(x)(sin(x));

f=@(x,H,z)(norm(H*x -z)^2);
df=@(x,H,z)(2*H'*(H*x-z));
fz=@(x,H,b)(H*x + b);

prox=@(x,lambda,gamma)(((x>lambda*gamma)).*(x-lambda*gamma)+...
    (x<-lambda*gamma).*(x+lambda*gamma) +...
    (x<=lambda*gamma |x>=-lambda*gamma).*(0));

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

% Descente de gradient
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

figure(3)
hold on
plot(t,sin(t),'r');
plot(t,z,'k');
plot(t,y);
plot(t,z,'*');
legend("sin(x)","signal bruité","Methode analytique")

eps = 0.00001;
x = sin(t)';
dim = 3;
gamma = 0.01;
yi=[y];
ly=[norm(x,1)];
compteur=1;

f1 = @(x)(norm(H*x-z,2)^2);
df1 = @(x)(2*x);

while delta> eps && compteur<500
    compteur=compteur+1;
    %Descente de gradient sur f
    zi = x - gamma * df1(x); 
    %point proximal sur g
    y1=prox(zi, lambda, gamma);
    yi=[yi,y1];
    delta=norm(yi(compteur)-yi(compteur-1));
    x=y1;
    ly=[ly;norm(x,1)];
   
end
figure(4)
hold on
plot(ly)
title('Fonction de coût')
disp(y1)