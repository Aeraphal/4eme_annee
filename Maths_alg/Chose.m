clear variables;
k=0;
for i=1:15
   v=1/i^2;
   k=v+k;
end
k

n=1;
s=0;
while s < pi^2/6-10^-3
    s=s+1/n^2;
    n=n+1;
end
n-1

n=1;
q=0;
while (((q)^2)^(1/2)-(log(2)^2)^(1/2))^2^(1/2) > 10^-4
    q=q+(-1)^(n+1)/n;
    n=n+1;
end
n-1