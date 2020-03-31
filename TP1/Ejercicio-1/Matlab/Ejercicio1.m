function [med, sigma] = ejercicio1(lambda, samples, bins)
    unif = unifrnd(0,1,[1 samples]);
    exp_dist = log(1./(1 - unif))/lambda;
    
    aux = 0:3/samples:3 - 3/samples;
    exp_teo = lambda*exp(-lambda*aux);
    
    h = histogram(exp_dist,'Normalization','probability') ;        
    %h = hist(exp_dist, bins);
    %h = histfit(exp_dist, bins, 'exponential');
    
    hold on
    p = plot(aux, exp_teo);
    p(1).LineWidth = 2.5;
    
    med = mean(exp_dist);
    sigma = std(exp_dist)^2;
end