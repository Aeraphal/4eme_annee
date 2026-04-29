clear variables;
close all;


fprintf('===== Test =====\n');

choix = input('Voulez vous la loi uniforme(1), la loi de Bernoulli(2), la loi binomiale(3) ou la loi geometrique(4) : ');
tirages = input('le nombre de tirage que vous souhaitez : ');
switch choix
    
    case 1
        fprintf('===== vous faites la loi uniforme =====\n');
        n = input('Le nombre d element : ');
        tabl = zeros(1,tirages);
        
        Ex = (n +1)/2;
        Vx = (n^2 -1)/12;
        ecartt=Vx^(1/2);
        
        
        k=ones(1,n);
        Px=k*1/n;
        k = linspace(1,n,n);
        
        
        for i = 1:tirages
            tirage = LoiUniforme(n);
            tabl(i) = tirage;

        end
        
        figure(1);
        hold on;
                
        htirages=histogram(tabl,'Normalization','probability');
        

        hX=bar(k,Px,'r'); 
        xlabel('K');
        ylabel('P(X=K)');
        title('Histogramme des probabilites LoiUniforme')
        legend('Empirique','théorique');
        
        Ex2=mean(tabl);
        
        ecart=std(tabl);

        fprintf('===== Affichage =====\n');
        disp(['esperance theorique : ',num2str(Ex)]);
        disp(['esperance empirique : ',num2str(Ex2)]);
        disp(['ecart type theorique : ',num2str(ecartt)]);
        disp(['ecart type empirique : ',num2str(ecart)]);
        
        
        
   
        
        
        
        
    case 2
        
        fprintf('===== vous faites la loi LoiBernoulli =====\n');
        p = input('La probabilité p : '); 
        
        tabl = zeros(1,tirages);
        
        Ex = p;
        Vx = p*(1-p);
        ecartt=Vx^(1/2);
        
        k=[0,1];
        Px = [1-p,p];
        
        
        
        for i = 1:tirages
            tirage = LoiBernoulli(p);
            tabl(i) = tirage;

        end
        
       
        figure(1);
        hold on;
                
        htirages=histogram(tabl,'Normalization','probability');
        
        hX=bar(k,Px,'r'); 
        xlabel('K');
        ylabel('P(X=K)');
        title('Histogramme des probabilites LoiBernoulli')
        legend('Empirique','théorique');
        
        Ex2=mean(tabl);
        
        ecart=std(tabl);

        fprintf('===== Affichage =====\n');
        disp(['esperance theorique : ',num2str(Ex)]);
        disp(['esperance empirique : ',num2str(Ex2)]);
        disp(['ecart type theorique : ',num2str(ecartt)]);
        disp(['ecart type empirique : ',num2str(ecart)]);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    case 3
        fprintf('===== vous faites la loi Binomiale =====\n');
        n = input('Le nombre de sous tirages : ');        
        p = input('La probabilité p : ');
        tabl = zeros(1,tirages);
        
        Ex = n*p;
        Vx = n*p*(1-p);
        ecartt=Vx^(1/2);
        
        
        k = 0:n;
        Px=k;
        for i=0:n
           Px(1,i+1)=nchoosek(n,i)*p^k(1,i+1)*(1-p)^(n-k(1,i+1)); 
        end
        
        
        
        
        for i = 1:tirages
            tirage = LoiBinomiale(n,p);
            tabl(i) = tirage;

        end
        
        figure(1);
        hold on;
                
        htirages=histogram(tabl,'Normalization','probability');
        
        hX=bar(k,Px,'r'); 
        xlabel('K');
        ylabel('P(X=K)');
        title('Histogramme des probabilites LoiBinomiale')
        legend('Empirique','théorique');
        
        Ex2=mean(tabl);
        
        ecart=std(tabl);

        fprintf('===== Affichage =====\n');
        disp(['esperance theorique : ',num2str(Ex)]);
        disp(['esperance empirique : ',num2str(Ex2)]);
        disp(['ecart type theorique : ',num2str(ecartt)]);
        disp(['ecart type empirique : ',num2str(ecart)]);
        
        
        
        
        
        
        
        
        
    case 4
        
        fprintf('===== vous faites la loi Geometrique =====\n');
        p = input('La probabilité p : ');
        
        tabl = zeros(1,tirages);
        
        Ex = 1/p;
        n=floor(4*Ex);
        Vx = (1-p)/p^2;
        ecartt=Vx^(1/2);
        
        
        k = linspace(1,n,n);
        Px=((1-p).^(k-1))*p;
       
        
        
        for i = 1:tirages
            tirage = LoiGeometrique(p);
            tabl(i) = tirage;

        end
        
        figure(1);
        hold on;
                
        htirages=histogram(tabl,'Normalization','probability');
        
        %colorList = get(gca,'ColorOrder');
        %b = bar(nan(2,2));
        %set(b,{'FaceColor'},num2cell(colorList(1:2,:),2))
        %legend(b,{'Empirique','théorique'});
        bar(k,Px,'r'); 
        xlabel('K');
        ylabel('P(X=K)');
        title('Histogramme des probabilites LoiGeometrique')
        legend('Empirique','théorique');
        
        Ex2=mean(tabl);
        
        ecart=std(tabl);

        fprintf('===== Affichage =====\n');
        disp(['esperance theorique : ',num2str(Ex)]);
        disp(['esperance empirique : ',num2str(Ex2)]);
        disp(['ecart type theorique : ',num2str(ecartt)]);
        disp(['ecart type empirique : ',num2str(ecart)]);
        
end




