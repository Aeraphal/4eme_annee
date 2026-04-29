function X = LancerDeSixFaces(n)
    X = randi([1,6],n,1);

    figure(1);
    fprintf('===== Exo 1 =====\n');
    hX=histogram(X);   % hX contient un certains nombre d'informations comme par exemple ...
    disp(['les effectifs : ',num2str(hX.Values)]);       
    fprintf('\n');

end
