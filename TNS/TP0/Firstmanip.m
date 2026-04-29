clear variables;
close all;
x=0:0.01:2*pi;
y=exp(-x/2).*cos(2*x).^2;
plot(x,y,'color','b','linewidth',2);
grid on; 

