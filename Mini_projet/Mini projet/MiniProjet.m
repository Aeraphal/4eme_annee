clear variables;
close all;


X = im2double(imread('leopard.png'));

proxabs=@(x,g) (x>g).*(x-g) + (x<-g).*(x+g);



grad_u=@(u,v,z,lambda)(u+v-z + 2*lambda*opBt(opB(u)));

grad_v=@(u,v,z,y,eta)(u+v-z-eta*opDt(-opD(v)+y));


z=X;
dim=length(X);
taille=size(X);


u=rand(taille);
v=rand(taille);
x=u+v;


gamma=0.4;
eps= 0.0001;
delta=15;
lambda=0.1;
mu=0.05;
eta1=0.1:0.1:2;
compteur=1;

y=opD(v);

for i = 1:length(eta1)
    while delta> eps && compteur<300
        compteur=compteur+1;
        eta = eta1(i);

        u= u -gamma*grad_u(u,v,z,lambda);             %gamma*proxabs(y/gamma,mu/gamma)

        y = x-u - gamma*grad_v(u,v,z,y,eta);
        v= proxabs(y,mu*gamma) ;                                  %gamma*proxabs(y1/gamma,mu/gamma);

        x1=v+u;

        delta=norm(x1-x,2);
        x=x1;
        disp([norm(u,"fro"),norm(y,"fro"),delta]);


    end

%%
    compteur = 1;
    delta=15;
    u_final = u ;    %-opBt(u) + z
    v_final = v;    %-opDt(v) + z;
    x_final =u+v;

    str = sprintf('image originale avec eta = %d',eta);
    figure(10*i)
    subplot(221)
    imshow(X)
    title(str)
    subplot(222)
    imshow(x_final)
    title('image lissee')
    subplot(223)
    imshow(u_final)
    title('u')
    subplot(224)
    imshow(v_final)
    title('v')
end