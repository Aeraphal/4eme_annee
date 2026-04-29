clear variables;
close all;



%Lecture de l'image 
% buildings=imread('images/qr-code.png');
buildings=imread('braille/braille4.png');
buildings_gray=rgb2gray(buildings);
[n,m]=size(buildings_gray);

%Les contours
Edge=edge(buildings_gray,'canny');

d_rho=1;
d_theta=1;

rho_max=hypot(n, m);
theta_max=ceil(180 / d_theta);


rho=-rho_max:d_rho:rho_max;
theta=1:d_theta:theta_max;

[a,b]=find(Edge);

H=zeros(length(theta),length(rho));



for i=1:length(a)
    for the=theta
        p=round(a(i)*cos(the*pi/180)+b(i)*sin(the*pi/180));
        if (abs(p)<=rho_max)
            rho_local=round((p+rho_max)/d_rho);
            H(the,rho_local)=H(the,rho_local)+1;
        end        
    end
end

%On centre l'origine en bas à gauche
H=flipud(H);


seuil = 0.4 * max(H(:));


% Recherche des pics dans l'accumulateur
maximum = [];
voisinnage = 5;

for theta_index = theta
    for rho_index = 1:length(rho)
        if H(theta_index, rho_index) > seuil
            % Vérifier si le pic est un maximum local
            max_local = true;
            
            for i = -voisinnage:voisinnage
                for j = -voisinnage:voisinnage
                    voisin_theta_index = theta_index + i;
                    voisin_rho_index = rho_index + j;
                    
                    % Ignorer les indices hors des limites de l'accumulateur
                    if voisin_theta_index < 1 || voisin_theta_index > theta_max || voisin_rho_index < 1 || ...
                            voisin_rho_index > length(rho)
                        continue;
                    end
                    
                    % Comparer la valeur du voisin avec le pic actuel
                    if H(voisin_theta_index, voisin_rho_index) > H(theta_index, rho_index)
                        max_local = false;
                        break;
                    end
                end
                
                if ~max_local
                    break;
                end
            end
            
            % Ajouter le pic à la liste des pics
            if max_local
                maximum = [maximum; theta_index, rho_index];
            end
        end
    end
end


% Tracer les droites correspondant aux pics détectés
figure(1);
subplot(221);
imshow(buildings);
hold on;

for i = 1:size(maximum, 1)
    theta_peak = -90 + (maximum(i, 1) - 1) * d_theta;
    rho_peak = (maximum(i, 2) - ceil(rho_max / d_rho) - 1) * d_rho;
    
    % Convertir les paramètres en coordonnées de droite
    m = -cosd(theta_peak) / sind(theta_peak);
    b = rho_peak / sind(theta_peak);
    
%         m= cosd(rho_peak)/sind(theta_peak);
%         b= rho_peak/cosd(theta_peak);



    % Points de début et de fin de la droite
    x = 1:size(buildings, 2);
    y = m*x + b;
    
    % Tracer la droite
    plot(x, y, 'LineWidth', 0.5, 'Color', 'y');
end

hold off;


% % [maxlocH_m,maxlocH_n]=find(H>=seuil);
% maxlocH_m=  (maximum(:, 2)- ceil((rho_max / d_rho))-1)*d_rho;
% maxlocH_n= -90 + (maximum(:,1)-1)*d_theta;
% P0=maximum(:, 2) ./ sind((maximum(:,1)        ));
% P1=maximum(:, 2) ./   cosd((maximum(:,1)         ));

% % figure(2)
% % subplot(111)
% imshow(buildings_gray)
% hold on;
% for i=1:length(maximum(:, 2))
%     plot([0 P0(i) ],[ P1(i) 0 ] )
% end

