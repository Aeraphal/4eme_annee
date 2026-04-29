function [prob_est, Cic] = calc_hist(x,M)
    x_min = min(x);
    x_max = max(x);
    N = length(x);
    switch nargin
        case 1
            
            x_opt = 3.49 * std(x)/(N^(1/3));
            M = floor(((x_max-x_min)/x_opt));
            %%Cic = x_min+x_opt/2:x_opt:x_max-x_opt/2;
            hold on;
            [prob_est,Cic] = hist(x,M);
            bar(Cic,prob_est/(N*x_opt));
            legend(['Histogramme de X avec M = ', num2str(M), ' echantillons ']);
            ylabel('Px');
            xlabel(['Centres d’intervalles calculés avec un Delta_X optimale : ', num2str(x_opt)]);

        case 2
            x_opt = (x_max-x_min)/M;

            %%Cic = x_min+delta_x/2:delta_x:x_max-delta_x/2;
            hold on;
            [prob_est,Cic] = hist(x,M);
            bar(Cic,prob_est/(N*x_opt));
            legend(['Histogramme de X avec M = ', num2str(M), ' echantillons ']);
            ylabel('Px');
            xlabel(['Centres d’intervalles calculés avec un Delta_X imposée : ', num2str(x_opt)]);

end