%*************************************************************************
% Cette fonction calcule le niveau de l'incidence d’un rayon entre deux
% points a et b avec les différentes pixels d'une image représentée par une
% matrice carrée n par n. Le résultat est deux matrices carrées de même
% taille. La première, indm contient des 0 et des 1. La valeur 1
% représente les pixels traversés par le rayon. Les valeurs des
% éléments non nuls de la matrice windm représentent la fraction (par
% rapport à la largeur de la pixel) du rayon traversant le pixel. Les deux
% vecteurs ind1 et ind2 représentent, respectivement, les abscisses et les
% ordonnées des pixels traversées par le rayon.
% Mohammad Arzi - Mars 2018

function [indm,windm,ind1,ind2]=find_ray_pixel_incidence(n,a,b)
    x1=a(1,1);y1=a(2,1);x2=b(1,1);y2=b(2,1);
    m=n;
    alphax=zeros(1,m+1);
    xplanes=0:n;yplanes=0:m;
    XM=max(x1,x2);xm=min(x1,x2);YM=max(y1,y2);ym=min(y1,y1);
    indxp=find((xm)<=xplanes & (XM)>=xplanes);
    for k=1:length(indxp)
        if ((XM-xm)>0)
            alphax(indxp(k))=(xplanes(indxp(k))-x1)/(x2-x1);
        else
            alphax(indxp(k))=0;
        end
    end
    indyp=find((ym)<=yplanes & (YM)>=yplanes);
    for k=1:length(indyp)
        if((YM-ym)>0)
            alphay(indyp(k))=(yplanes(indyp(k))-y1)/(y2-y1);
        else
            alphay(indyp(k))=0;
        end
    end
    alphas=union(alphax,alphay);
    indm=zeros(m,n);windm=zeros(m,n);
    for k=1:length(alphas)-1
        midalphak=(alphas(k+1)+alphas(k))/2;
        xij=x1+midalphak*(x2-x1);
        yij=y1+midalphak*(y2-y1);
        JJ=max(1,ceil(xij));
        II=max(1,ceil(yij));
        indm(II,JJ)=1;
        windm(II,JJ)=alphas(k+1)-alphas(k);
    end
    [ind1,ind2]=find(indm==1);
end

