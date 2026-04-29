function [t,y1] = F(t,y,GM)
%F Summary of this function goes here
%   Detailed explanation goes here
xn = y(1);
yn = y(2);
y1 = [y(3),y(4),-GM*xn/(xn^2+yn^2)^(3/2),-GM*yn/(xn^2+yn^2)^(3/2)];
t = t+h;

end

