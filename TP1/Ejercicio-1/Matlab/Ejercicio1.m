function [med, sigma] = ejercicio1(lambda, samples, bins)
    unif = unifrnd(0,1,[1 samples]);
    exp_dist = log(1./(1 - unif))/lambda;
    %exp_dist = exp_dist.*(lambda/exp_dist(1));
    %figure(1)
    %histfit(exp_dist, bins, 'exponential')
        
    aux = 0:1/samples:6;
    exp_teo = lambda*exp(-lambda*aux);
    
    %figure(2)
    %histogram(exp_dist, bins, 'Normalization', 'probability')
    hist(exp_dist, bins)
    hold on
    plot(aux, exp_teo*50);
    
    med = mean(exp_dist);
    sigma = std(exp_dist)^2;
end