function [Ix,Iy,It]=gradients(I1,I2)
    Ix = conv2(I1,0.25* [-1 1; -1 1],'same') + conv2(I2, 0.25*[-1 1; -1 1],'same');
    Iy = conv2(I1, 0.25*[-1 -1; 1 1], 'same') + conv2(I2, 0.25*[-1 -1; 1 1], 'same');
    It = conv2(I1, -0.25*ones(2),'same') + conv2(I2, 0.25*ones(2),'same');
end