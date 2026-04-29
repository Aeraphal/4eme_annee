


% Charger l'image
image = imread('buildings.png');

% Conversion en niveaux de gris
image_grayscale = rgb2gray(image);

% Détection des contours
image_edges = edge(image_grayscale, 'canny');

figure(1);
subplot(222);
imshow(image_edges,[]);

% Définition des paramètres de l'espace de votes de Hough
theta_resolution = 0.5; % Résolution de l'angle en degrés
rho_resolution = 1; % Résolution de la distance en pixels

% Dimensions de l'image
[height, width] = size(image_edges);

% Calcul de l'accumulateur de Hough
max_rho = hypot(height, width);
num_theta = ceil(180 / theta_resolution);
accum = zeros(num_theta,  2*ceil(max_rho / rho_resolution) + 1);

% Parcourir tous les pixels de contours
[y_indices, x_indices] = find(image_edges);
num_edge_pixels = numel(y_indices);

for k = 1:num_edge_pixels
    x = x_indices(k);
    y = y_indices(k);

    % Parcourir tous les angles de theta
    for theta_index = 1:num_theta
        theta = -90 + (theta_index - 1) * theta_resolution;
        
        rho = x * cosd(theta) + y * sind(theta);
        
        % Convertir les coordonnées en indices de l'accumulateur
        rho_index = round(rho / rho_resolution) + ceil(max_rho / rho_resolution) + 1;
        
        % Incrémenter le vote dans l'accumulateur
        accum(theta_index, rho_index) = accum(theta_index, rho_index) + 1;
    end
end

figure(1);
subplot(223);
imshow(H,[]);

% Définir le seuil pour la détection des droites
vote_threshold = 0.4 * max(accum(:));

% Recherche des pics dans l'accumulateur
peaks = [];
neighborhood_size = 5;

for theta_index = 1:num_theta
    for rho_index = 1:size(accum, 2)
        if accum(theta_index, rho_index) > vote_threshold
            % Vérifier si le pic est un maximum local
            is_local_max = true;
            
            for i = -neighborhood_size:neighborhood_size
                for j = -neighborhood_size:neighborhood_size
                    neighbor_theta_index = theta_index + i;
                    neighbor_rho_index = rho_index + j;
                    
                    % Ignorer les indices hors des limites de l'accumulateur
                    if neighbor_theta_index < 1 || neighbor_theta_index > num_theta || neighbor_rho_index < 1 || neighbor_rho_index > size(accum, 2)
                        continue;
                    end
                    
                    % Comparer la valeur du voisin avec le pic actuel
                    if accum(neighbor_theta_index, neighbor_rho_index) > accum(theta_index, rho_index)
                        is_local_max = false;
                        break;
                    end
                end
                
                if ~is_local_max
                    break;
                end
            end
            
            % Ajouter le pic à la liste des pics
            if is_local_max
                peaks = [peaks; theta_index, rho_index];
            end
        end
    end
end

% Tracer les droites correspondant aux pics détectés
figure(1);
subplot(221);
imshow(image);
hold on;

for i = 1:size(peaks, 1)
    theta_peak = -90 + (peaks(i, 1) - 1) * theta_resolution;
    rho_peak = (peaks(i, 2) - ceil(max_rho / rho_resolution) - 1) * rho_resolution;
    
    % Convertir les paramètres en coordonnées de droite
    m = -cosd(theta_peak) / sind(theta_peak);
    b = rho_peak / sind(theta_peak);
    
    % Points de début et de fin de la droite
    x = 1:size(image, 2);
    y = m*x + b;
    
    % Tracer la droite
    plot(x, y, 'LineWidth', 2, 'Color', 'r');
end

hold off;
