function [ rayleigh_samples ] = rayleigh_dist( sig, muestras )
%RAYLEIGH_DIST Muestras distribucion Rayleigh
%   Metodo Monte Carlo, muestras con distribucion Rayleigh
samples = unifrnd(0,1,1, muestras);
rayleigh_samples = sig*sqrt(-2*log(samples));

end

