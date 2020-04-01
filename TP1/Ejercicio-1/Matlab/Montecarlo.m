function [med, sigma2] = montecarlo(lambda, samples, bins)
    unif = unifrnd(0,1,[1 samples]);
    exp_dist = log(1./(1 - unif))/lambda;
    
    aux = 0:4/samples:4 - 4/samples;
    exp_teo = lambda*exp(-lambda*aux);
    
    h = histogram(exp_dist, bins,'Normalization','probability');
    [ymax, xmax] = max(h.Values);
       
    hold on
    p = plot(aux, exp_teo*ymax/exp_teo(1));
    p(1).LineWidth = 2.5;
    
    med = mean(exp_dist);
    sigma2 = std(exp_dist)^2;
end