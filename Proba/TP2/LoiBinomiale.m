function nbSucces=LoiBinomiale(n,p)
    nbSucces =0;
    for i=1:n
        nbSucces= nbSucces + LoiBernoulli(p);
    end
end