function [x,y,t]=Euler_2D(x0,y0,tmin,tmax,h,f,g)
t=tmin:h:tmax;
y=zeros(1,length(t));
x=zeros(1,length(t));
y(1)=y0;
x(1)=x0;
for k=1:length(t)-1
    % Euler explicite
    y(k+1)=y(k)+h*g(t(k),x(k),y(k));
    x(k+1)=x(k)+h*f(t(k),x(k),y(k));
end
end