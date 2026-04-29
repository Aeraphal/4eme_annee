X=im2double(imread('leopard.png'));

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
                            
    x1=y-gamma*proxg(y,g );
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




