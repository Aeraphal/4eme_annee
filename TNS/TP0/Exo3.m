clear variables
x = 0.00001:0.00001:1;
y = (x+3)./((2.*x+1).^(1/2));
z = trapz(x,y);
z



a = pi/10000:pi/10000:2*pi;
f = @(x)sin(x).^4./a.^4;
b = f(a);
c = trapz(a,b);
c
