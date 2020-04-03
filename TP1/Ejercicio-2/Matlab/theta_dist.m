function [ angulos ] = theta_dist(muestras)
%THETA_DIST Muchos angulos dist uniforme
%   Monte Carlo para numeros entre 0 y 2pi
samples = unifrnd(0,1,1, muestras);
angulos = samples*2*pi;
end

