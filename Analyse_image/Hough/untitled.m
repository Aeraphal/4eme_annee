clear variables;
close all;

%1.
I = imread('./images/maison.png');
I = im2double(I);
I = rgb2gray(I);

figure(1);
subplot(221);
imshow(I,[]);
title("Image originale");

%2.
[N1,N2] = size(I);
rho_max = sqrt((N1-1)^2 + (N2-1)^2); 

%3.

[~,threshold] = edge(I,'sobel');
fudgeFactor = 0.8;
contour = edge(I,'sobel',threshold * fudgeFactor);


contour_test = 255 - I;

figure(1);
subplot(222);
imshow(contour_test,[]);
title("Contour de l'image");

%4.
H = zeros(N1,N2);

for i = 1:N1
    for j = 1:N2
        if contour_test(i,j) > 254.8
            for t = 1:N2
                theta = pi*t/N2;
                rho = i*cos(theta) + j*sin(theta);
                H(round((rho + rho_max)*N1/(rho_max*2)),t) = H(round((rho + rho_max)*N1/(rho_max*2)),t)+1;
            end
        end
    end
end

figure(1);
subplot(223);
imshow(H, []);
title("Matrice d'accumulation");

max_locaux = islocalmax(H,'MinProminence',254.8);

figure(1);
subplot(224);
imshow(max_locaux, []);
title("Maximums locaux de la matrice d'accumulation");

for i = 1:N1
   for j = 1:N2
       if max_locaux(i,j) > 0
           theta = pi*j/N2;
           rho = i*(rho_max*2)/N1 - rho_max;
           
           if theta <= pi/2 && theta >= 0 && rho <= sqrt(N1^2 + N2^2)/2
               c = [0,(cos(theta)*(rho*cos(theta))/sin(theta)) + rho*sin(theta)];
               d = [(sin(theta)*(rho*sin(theta))/cos(theta)) + rho*cos(theta),0]; 
               comp_cont = c(2);
               
               pente = (d(2)-c(2))/(d(1)-c(1));
           
           
               x = 1:N2;
               y = pente*x + comp_cont;
               
               figure(1);
               subplot(221);hold on;
               plot(x,y,"r-");
           end    
           
           if theta > pi/2 && theta <= pi  
               c = [255,(cos(theta)*(rho*cos(theta))/sin(theta)) + rho*sin(theta)];
               d = [(sin(theta)*(rho*sin(theta))/cos(theta)) + rho*cos(theta),0]; 
               comp_cont = c(2);
           end       
               
       
           
       end
   end
end




