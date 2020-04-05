function [ rayleigh_samples ] = rayleigh_dist( sigma, muestras )
%RAYLEIGH_DIST Muestras distribucion Rayleigh
%   Metodo Monte Carlo, muestras con distribucion Rayleigh
samples = unifrnd(0,1,1, muestras);
rayleigh_samples = sigma*sqrt(-2*log(samples));

end

