function [yRK,t]=fct_RK2(y0,tmin,tmax,h,beta,f)
t=tmin:h:tmax;
yRK=zeros(1,length(t));
yRK(1) = y0;
for k=1:length(t)-1
    % RK ordre 2
    k1=f(t(k),yRK(k));
    k2=f(t(k)+h/(2*beta),yRK(k)+k1*h/(2*beta));
    yRK(k+1)=yRK(k)+h*((1-beta)*k1+beta*k2);
end



