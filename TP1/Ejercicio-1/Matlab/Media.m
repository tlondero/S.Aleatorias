function [med] = media(lambda, samples, bins, it)
    med_aux = [1 it];
    for i = 1:it
        unif = unifrnd(0,1,[1 samples]);
        exp_dist = log(1./(1 - unif))/lambda;
        med_aux(i) = mean(exp_dist);
    end
    h = histfit(med_aux, bins);
    med = med_aux;
end