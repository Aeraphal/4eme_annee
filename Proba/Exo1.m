clear variables;
close all;

LancerDeSixFaces(15);


compteurA = 0;
compteurB = 0;
n = 10000;
for i = 1:n  %Nombre d'experience%
    k = randi([1,6],4,1);
    if max(k) == 6
        compteurA = compteurA + 1;
    end
    
    Double = [6 ; 6];

    d1 = randi([1,6],24,1);
    d2 = randi([1,6],24,1);
    d3 = d1 + d2;
    if max(d3) == 12
        compteurB = compteurB + 1; 
    end

end

X = [compteurA/n compteurB/n];

fprintf('===== Exo 1 B =====\n');
disp(['les probabilités sont : ',num2str(X)]);       
fprintf('\n');



