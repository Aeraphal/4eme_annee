function [yEuler,t] = fct_Euler(y0,tmin,tmax,h,f)
t=tmin:h:tmax;
yEuler=zeros(1,length(t));
yEuler(1) = y0;
for k=1:length(t)-1
    % Euler explicite
    yEuler(k+1)=yEuler(k)+h*f(t(k),yEuler(k));
end