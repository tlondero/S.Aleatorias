function [med, sigma2] = iteraciones(lambda, samples, bins, it)
    med_aux = [1 it];
    sigma2_aux = [1 it];
    for i = 1:it
        unif = unifrnd(0,1,[1 samples]);
        exp_dist = log(1./(1 - unif))/lambda;
        med_aux(i) = mean(exp_dist);
        sigma2_aux(i) = std(exp_dist)^2;
    end
    med = med_aux;
    sigma2 = sigma2_aux;
end