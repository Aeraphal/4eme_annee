clear variables;
close all;

% 1. Charger l'image
I = imread('buildings.png');
I = im2double(I);
I = rgb2gray(I);

figure(1);
subplot(221);
imshow(I, []);
title("Image originale");

% 2. Calculer rho_max
[N1, N2] = size(I);
rho_max = sqrt((N1-1)^2 + (N2-1)^2);

% 3. Détection des contours
[~, threshold] = edge(I, 'sobel');
fudgeFactor = 0.8;
contour = edge(I, 'sobel', threshold * fudgeFactor);

contour_test = 255 - I;

figure(1);
subplot(222);
imshow(contour_test, []);
title("Contour de l'image");

% 4. Calcul de l'accumulateur de Hough
H = zeros(N1, N2);

for i = 1:N1
    for j = 1:N2
        if contour_test(i, j) > 254.8
            for t = 1:N2
                theta = -pi/2 + (t) * (pi / N2);
                rho = i * cos(theta) + j * sin(theta);
                rho_index = round((rho + rho_max) * N1 / (2 * rho_max));
                H(rho_index, t) = H(rho_index, t) + 1;
            end
        end
    end
end

figure(1);
subplot(223);
imshow(H, []);
title("Matrice d'accumulation");

% 5. Recherche des maximums locaux
threshold_prominence = max(H(:)) * 0.35; % Ajuster le seuil si nécessaire
max_locaux = imregionalmax(H) & (H > threshold_prominence);
neighborhood_size = 20;

for theta_index = 1:N1
    for rho_index = 1:N2
        if max_locaux(theta_index, rho_index) > 0
            % Vérifier si le pic est un maximum local
            for i = -neighborhood_size:neighborhood_size
                for j = -neighborhood_size:neighborhood_size
                    neighbor_theta_index = theta_index + i;
                    neighbor_rho_index = rho_index + j;
                    
                    % Ignorer les indices hors des limites de l'accumulateur
                    if neighbor_theta_index < 1 || neighbor_theta_index > N1 || neighbor_rho_index < 1 || neighbor_rho_index > N2
                        continue;
                    end
                    
                    max_locaux(neighbor_theta_index, neighbor_rho_index) = 0;
                end
            end
            
            % Ajouter le pic à la liste des pics
            max_locaux(theta_index,rho_index) = 1;
           
        end
    end
end


figure(1);
subplot(224);
imshow(max_locaux, []);
title("Maximums locaux de la matrice d'accumulation");

% 6. Tracé des droites
theta_values = linspace(-pi/2, pi/2, N2);

for rho_index = 1:N1
    for theta_index = 1:N2
        if max_locaux(rho_index, theta_index)
            rho = (rho_index) * (2 * rho_max) / N1 - rho_max;
            theta = theta_values(theta_index);
            
            if theta == 0 || theta == pi
                x = [rho, rho];
                y = [1, N1];
            else
                x = 1:N2;
                y = (rho - x * cos(theta)) / sin(theta);
            end
            
            figure(1);
            subplot(221);
            hold on;
            plot(y, x, 'r-');
        end
    end
end
