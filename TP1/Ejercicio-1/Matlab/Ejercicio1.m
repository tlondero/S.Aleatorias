function [med, sigm] = ejercicio1(lambda)
    unif = unifrnd(0,1,[1 5000]);
    exp_dist = log(1./(1-unif))/lambda;
    aux = 0:1/5000:6;
    exp_teo = lambda*exp(-lambda*aux);

    histogram(exp_dist, 'Normalization', 'probability') %plot(hist(exp_dist, size(exp_dist,2))/max(exp_dist))
    hold on
    plot(aux, exp_teo);

    med = mean(exp_dist);
    sigm = std(exp_dist)^2;
end