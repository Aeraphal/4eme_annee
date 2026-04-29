close all;
clear variables;
n = 2;
switch n
    case 1
        I = make_your_image();
    case 2
        I = imread('Lena_couleur.jpg');
        I = (I(:,:,1)+I(:,:,2)+I(:,:,3))/3;
end        
        
figure(1);
subplot(221);
imshow(I,[]);
[n,p] = size(I);
I2 = I+randn(n,p)*5;

subplot(222);
imshow(I2,[]);
tau = 1;
U = im2double(I);

for i = 1:1
    gradN = U * (diag(ones(1,n-1),-1)-1);
    gradE = (diag(ones(1,n-1),-1)-1)*U;
    gradS = U * (diag(ones(1,n-1),1)-1);
    gradW = (diag(ones(1,n-1),1)-1)*U;
    

    U = U+tau*(gradN + gradE + gradS + gradW);
    
    
end

subplot(223);
imshow(U,[]);

figure(2);
subplot(221);
imshow(gradN,[]);
subplot(222);
imshow(gradE,[]);
subplot(223);
imshow(gradS,[]);
subplot(224);
imshow(gradW,[]);
