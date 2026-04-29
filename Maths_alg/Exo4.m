clear variables
Y=-4:0.001:4;
a = 3*porte(Y+3);
b = porte(Y./4);
Z = 0:1:4;





subplot(3,2,1)
plot(Y,a,'.r')
legend('porte1')
grid on
xlabel('Y')
ylabel('Z')








