clear variables;
close all;

%% 1.1 Sous-différentielle et algorithme de sous-gradient

f=@(x)(abs(x));
df=@(x,c)((x==0)*c+(~(x==0))*(sign(x)));

% Valeur de départ
x=-2;

c=0.2;
eps= 10^-4;
delta=1;
lambda=0.5;
xi=[x];
l=[f(x)];
compteur=0;

while delta> eps && compteur<500
    compteur=compteur+1;
    x1=x-lambda*df(x,c);
    xi=[xi,x1];
    delta=norm(df(x1,c));
    x=x1;
    l=[l;f(x)];
    
end
figure(1)
hold on
plot(-3:0.1:3,abs(-3:0.1:3))
plot(xi,l,'*-')
title('Methode du sous gradient')
disp(x1)


%% 1.2 Enveloppe de Moreau

a=5;
b=3;
gamma =0.1;

t=-3:0.01:3;

f=@(x,a,b)(abs(a*x+b));
M=@(x,a,b,gamma) (  (x>-b/a + a*gamma).*(a*x+b -a^2*gamma/2)...
                   +(x<-b/a - a*gamma).*(-a*x-b - a^2*gamma/2) ...
                   +((x<=-b/a + a*gamma) & (x>=-b/a - a*gamma)).*(1/(2*gamma)*((x+b/a).^2))  );

figure(2)
fonction=f(t,a,b);
Moreau=M(t,a,b,gamma);
hold on
grid on
plot(t,fonction)
plot(t,Moreau)
legend("|ax+b|",'Enveloppe de Moreau')




%% 1.3 Operateur Proximal

prox1=@(x,z,gamma)((2*gamma*z+x)/(2*gamma+1));
prox2=@(x,lambda,gamma)(((x>lambda*gamma)).*(x-lambda*gamma)+...
    (x<-lambda*gamma).*(x+lambda*gamma) +...
    (x<=lambda*gamma |x>=-lambda*gamma).*(0));

z=1;
lambda=3;
gamma=0.00001;
f=prox1(t,z,gamma);
g=prox2(t,lambda,gamma);


figure(3)
hold on
plot(t,f)
plot(t,(t-z).^2)
legend("(.z)²","prox 1D")
figure(4)
hold on
plot(t,lambda*abs(g))
plot(t,g)
legend("lambda|.|","prox 1D")


%% 2.1





eps= 10^-4;
delta=1;
% On utilise prox2 déjà codé
lambda=1;
gamma=0.1;
x=2;
xi=[x];
l=[abs(x)];
compteur=0;

while delta> eps && compteur<5000
    compteur=compteur+1;
    x1=prox2(x,lambda,gamma);
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


%% 2.2

f1=@(x)(norm(x,2)^2);
df2=@(x)(2*x);

eps= 10^-4;
delta=1;
% On utilise prox2 déjà codé
dim=1;
lambda=2;

gamma=0.05;
x=3*rand(1,dim);
xi=[x];

l=[norm(x,1)];




compteur=1;
while delta> eps 
    compteur=compteur+1;
    x1=prox2(x-gamma*df2(x),lambda,gamma);
    xi=[xi,x1];
    delta=norm(xi(compteur)-xi(compteur-1));
    x=x1;
    l=[l;norm(x,1)];
    
end
figure(6)
hold on
if dim==1
    plot(-3:0.1:3,abs(-3:0.1:3))
    plot(xi,l,'*-')
    title('Algorithme du gradient proximal')
    disp(x1)
else
    
    plot(l)
    title('Fonction de coût')
    disp(x1)
end




%% 3.1

q=2;

switch q
    case 1
f3=@(x,H,z)(norm((H*x -z),2)^2);
df3=@(x,H,z)(2*H'*(H*x-z));
fz=@(x,H,b)(H*x+b);


dim=length(t);
b=randn(dim,1);
x=sin(t)';
H=opH(eye(dim),"gaussian",5);
z=fz(x,H,b);

gamma=1;



eps= 10^-4;
delta=15;
lambda=0.4;
xi=[x];
l=[norm(f3(x,H,z),1)];
compteur=1;

while delta> eps && compteur<100000
    compteur=compteur+1;
    x1=prox2(x-lambda*df3(x,H,z),lambda,gamma);
    delta=norm(xi(compteur)-xi(compteur-1),1);
    x=x1;
    xi=[xi,x1];
    l=[l;norm(f3(x,H,z),1)];
    
end


figure (7)
hold on
%plot(t,sin(t),'r')
plot(l);
%legend("sin(x)","Methode de gradiant proximal")


    case 2
    f4=@(x,z)(norm((x -z),2)^2);
    proxg=@(x,g) (x>g).*(x-g) + (x<-g).*(x+g);
    grad=@(x,z)(2*(x-z));

    X = im2double(imread('parrot-gray-blur-noisy.png'));
    %w=zeros(1,400)+1;
    X=X(1:399,1:399);
    n=length(X);   
    z=X(:);
    ker = 'gaussian';  

    lambda = 0.1;   
    
    Gamma=0.01;  %%opL(0.01*eye(n))

%% Gradient proximal
eps= 10^-8;
delta=1;


l=norm(f4(x,z));
compteur=1;
while delta> eps && compteur<1000
    compteur=compteur+1;
    x1=prox2(x-lambda*grad(x,z),lambda,Gamma);
    delta=norm(x1-x,1);
    x=x1;
    l=[l,norm(f4(x,z))];
end
disp(compteur)
    figure(7)
    hold on
    subplot(311)
    imshow(reshape(x,size(X)))
    subplot(312)
    imshow(X)
    subplot(313)
    plot(l)
    title('Algorithme du gradient proximal')

end




%% 3.2


image = 1; 
switch image
    case 1 
proxg=@(x,g) (x>g).*(x-g) + (x<-g).*(x+g);
grad=@(x,z)(-opD(-opDt(x)+z));

gamma=0.5;
z=X(:);
dim=length(X);
dim1=length(z);
b=randn(dim1,1);
x=rand(dim1,1);



eps= 0.001;
delta=15;
lambda=0.2;

compteur=1;

while delta> eps && compteur<15000
    compteur=compteur+1;
    
    y=x-gamma*grad(x,z);
                            
    x1=y-gamma*prox2(y,lambda,gamma);
    delta=norm(x-x1,2);
    x=x1;
    
end

x_final = -opDt(x) + z;

figure (9)
hold on
plot(l);
figure(10)
subplot(221)
imshow(X)
subplot(222)
imshow(reshape(x_final,size(X)))


    case 0
end










