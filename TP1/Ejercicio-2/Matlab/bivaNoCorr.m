function [ x,y ] = bivaNoCorr( mean,sigma, muestras )
%BIVANOCORR 2 vectores de muestras con valores dist normal no correlacionados
%   Uso las funciones rayleigh_dist y theta_dist para encontrar valores
%   para radio y angulo de las muestras. Dev
ray = rayleigh_dist(sigma,muestras);
thet = theta_dist(muestras);
x = ray.*(cos(thet));
y = ray.*sin(thet);

end

