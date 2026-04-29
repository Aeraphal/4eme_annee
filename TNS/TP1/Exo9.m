clear variables;close all; 



A=imread('barbara.jpg'); 
A = A(:,:,1);
[a,b]=size(A);
figure(1); 
subplot(2,2,1); 
imagesc(A); 
colormap gray;



tfA = fftshift(fft2(double(A)));
subplot(223);
imagesc(log10(abs(tfA)));
D = disque(a,b,60);
TP = tfA.*D;
subplot(224);
imagesc(log10(abs(TP)));
TPfin=abs(ifft2(TP));
subplot(222); imagesc(TPfin);