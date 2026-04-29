close all;
clear variables;
clc
question = 2;
Partie = 2;
Choix = 1;
switch Choix
    case 1
        n=300; 
        m=n; 
        r = 20;
    case 2
        m = 1000;
        n = 500;
        r = 58;
end
switch question
    case 1

        switch Partie
            case 1

                figure(1); 
                x=-n/2:n/2; 
                y=x; 
                lx=45; 
                ly=20; 
                M1=porte_2d(m,n,lx,ly); 
                subplot(1,3,1); 
                imshow(M1);
                tfM1 = abs(fftshift(fft2(M1)));
                subplot(132);
                imshow(tfM1);
                stfM1 = uint8(tfM1);
                subplot(133);
                imshow(stfM1);

            case 2
                D=disque(m,n,r); 
                subplot(1,3,1); 
                imshow(D);
                tfM1 = abs(fftshift(fft2(D)));
                subplot(132);
                imshow(tfM1);
                stfM1 = uint8(tfM1);
                subplot(133);
                imshow(stfM1);
        end
    case 2
        [x,y]=meshgrid(1:n,1:m); 
        M1=cos(0.5*x+0.5*y); 
        M2=cos(2*x+2*y); 
        M3=cos(0.5*x+0.5*y)+cos(0.6*x+0.8*y); 
        subplot(2,3,1); 
        imshow(M1);
        subplot(2,3,2); 
        imshow(M2);
        subplot(2,3,3); 
        imshow(M3);
        tfM1 = abs(fftshift(fft2(M1)));
        tfM2 = abs(fftshift(fft2(M2)));
        tfM3 = abs(fftshift(fft2(M3)));
        stfM1 = uint8(tfM1);
        stfM2 = uint8(tfM2);
        stfM3 = uint8(tfM3);
        subplot(234);
        imshow(stfM1);
        subplot(235);
        imshow(stfM2);
        subplot(236);
        imshow(stfM3);        
end