function [x,y,t]=fct_RK2_2D(x0,y0,tmin,tmax,pas,beta,F,G)
t=tmin:pas:tmax;
x=zeros(1,length(t));
y = x;
x(1) = x0;
y(1) = y0;
for k=1:length(t)-1
    %  ordre 2
    kf1=F(t(k),x(k),y(k));
    kg1=G(t(k),x(k),y(k));
    kf2=F(t(k)+pas/(2*beta),x(k)+kf1*pas/(2*beta),y(k)+kg1*pas/(2*beta));
    kg2=G(t(k)+pas/(2*beta),x(k)+kf1*pas/(2*beta),y(k)+kg1*pas/(2*beta));
    
    x(k+1)=x(k)+pas*((1-beta)*kf1+beta*kf2);
    y(k+1)=y(k)+pas*((1-beta)*kg1+beta*kg2);
end



