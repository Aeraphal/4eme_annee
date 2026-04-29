clear variables;
close all;

Pb = 5;
sigma = sqrt(Pb);
Fs = 500;
B = 160;
T = 100;
nu_0 = 100;
F1_ordre = 6;
Dnu = 16;
A = 1;
phi = rand()*2*pi;
Fc = 0;
FM = 0;


%M = zeros(123);
question = input('N exo ');

Xp = struct('sigma',sigma,'Fs',Fs,'B',B,'T',T);
[X,Xp] = CGN(Xp);

Sp = struct('Fs',Fs,'A',A,'Fc',nu_0,'FM',FM,'Phi',phi,'T',T,'W',[]);
[S,Sp,M] = OOK(Sp);

switch question
    case 1

        disp(['La moyenne de B = ', num2str(mean(X.data))]);
        disp(['La Variance de B = ', num2str(std(X.data)^2)]);

        Fp = struct('Fs',Fs,'F0',nu_0,'Dnu',Dnu,'order',F1_ordre,'class','Passe Bande');
        [Y,Fp] = BPF(X,Fp);
        disp(['La moyenne de YB = ', num2str(mean(Y.data))]);
        disp(['La Variance de YB = ', num2str(std(Y.data)^2)]);

        Z = SquareSig(Y);

        RC = [1/8,5/4,25/4];
        for i=1:3
            n = 3+i;
            figure(n);
            RCFp = struct('Fs',Fs,'RC',RC(i));
            [Wb,RCFp] = RCF (Z,RCFp);
            disp(['Le signal filtré Wb par RC = ', num2str(RC(i))]);
            disp(['La moyenne de Wb = ', num2str(mean(Wb.data))]);
            disp(['La Variance de Wb = ', num2str(std(Wb.data)^2)]);
            disp(['Le Kurtosis de Wb est = ', num2str(kurtosis(Wb.data))]);
            Wb_prime = Wb.data(:,floor(5*RC(i)*Fs):end);
            disp(['La moyenne corrigée de Wb'' = ', num2str(mean(Wb_prime))]);
            disp(['La Variance corrigée de Wb'' = ', num2str(std(Wb_prime)^2)]);
            disp(['Le Kurtosis corrigé de Wb'' est = ', num2str(kurtosis(Wb_prime))]);
        end

    case 2
        disp(['La moyenne de S = ', num2str(mean(S.data))]);
        disp(['La Variance de S = ', num2str(std(S.data)^2)]);
        Fp = struct('Fs',Fs,'F0',nu_0,'Dnu',Dnu,'order',F1_ordre,'class','Passe Bande');
        [Y,Fp] = BPF(S,Fp);
        disp(['La moyenne de Ys = ', num2str(mean(Y.data))]);
        disp(['La Variance de Ys = ', num2str(std(Y.data)^2)]);
        
        X_t = AddSig(X,S);
        [Yt,Fp] = BPF(X_t,Fp);
        
        Zt = SquareSig(Yt);
        
        RC = [1/8,5/4,25/4];
        for i=1:3
            n = 3+i;
            figure(n);
            RCFp = struct('Fs',Fs,'RC',RC(i));
            [Wsb,RCFp] = RCF (Zt,RCFp);
            disp(['******* Le signal filtré Ws+b par RC = ', num2str(RC(i)), ' *******']);
            Wsb_prime = Wsb.data(:,floor(5*RC(i)*Fs):end);
            disp(['La moyenne de Ws+b'' = ', num2str(mean(Wsb_prime))]);
            disp(['La Variance corrigée de Wb'' = ', num2str(std(Wsb_prime)^2)]);
            disp(['Le Kurtosis corrigé de Wb'' est = ', num2str(kurtosis(Wsb_prime))]);
        end

    case 3
        FM = 0.05;
        RC = 5/4;
        Sp = struct('Fs',Fs,'A',A,'Fc',nu_0,'FM',FM,'Phi',phi,'T',T,'W',[]);
        [S,Sp,M] = OOK(Sp);
        Xt = AddSig(X,S);
        Fp = struct('Fs',Fs,'F0',nu_0,'Dnu',Dnu,'order',F1_ordre,'class','Passe Bande');
        [Yt,Fp] = BPF(Xt,Fp);
        Zt = SquareSig(Yt);
        RCFp = struct('Fs',Fs,'RC',RC);
        [Wt,RCFp] = RCF (Zt,RCFp);
        
        seuil=zeros(length(Wt.time),1); %initialisation matrice
        for i=1:length(Wt.time)
            if (Wt.data(1,i)>0.72) %si depassement seuil 0.72
                seuil(i,1)=1; %on met 1 dans matrice
            else
                seuil(i,1)=-1; %sinon 0
            end
        end

        
        figure(9);
        hold on;
        subplot(4,1,1);
        plot(S.time,S.data);
        title('S(t)');
        xlabel('Temps')
        ylabel('Amplitude')        
        
        subplot(4,1,2);
        plot(Xt.time,Xt.data);
        title('X(t)');
        xlabel('Temps')
        ylabel('Amplitude')
        
        
        subplot(4,1,3);
        plot(Wt.time,Wt.data);
        title('W(t)');
        xlabel('Temps')
        ylabel('Amplitude')
        
        subplot(4,1,4);
        plot(Wt.time, seuil);
        title('Signal binaire détecté');
        xlabel('Temps')
        ylabel('Amplitude')
    case 4
        
        load SignalRecu_2
        [TxMsg,Xp ] = RxMessage_DQ(X,Xp);
        
        
end



% figure(2);
% plot(X.time,X.data);
% title(['Synthèse de bruit aléatoire sur une durée de ', num2str(T), ' seconde']);
% ylabel('Densité spectrale de puissance moyenne');
% xlabel('fréquence');


