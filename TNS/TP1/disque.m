function D=disque(n,m,r) 
    D=zeros(m,n); 
    for i=-floor(n/2):floor(n/2) 
        for j=-floor(m/2):floor(m/2) 
            if i^2+j^2<r^2
                D(j+floor(n/2)+1,i+floor(m/2)+1)=1; 
            end 
        end 
    end 
end