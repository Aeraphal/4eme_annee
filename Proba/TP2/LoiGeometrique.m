function n=LoiGeometrique(p)
    n =1;
    x=LoiBernoulli(p);
    while x==0
        x=LoiBernoulli(p);
        n= n + 1;
    end
end