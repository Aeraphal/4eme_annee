function [r1,r2,r3]=MyFunction(a,b) 
 
if length(a)~=length(b) 
    error('Les vecteurs doivent être de même longueur !'); 
end 
r1=sum(a.*b); 
r2=a'*b;  
r3=a*b';