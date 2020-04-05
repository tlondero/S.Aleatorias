function [ x,y ] = bivaNoCorr( mean1, mean2, sigma1, sigma2, muestras )
%BIVANOCORR 2 vectores de muestras con valores dist normal no correlacionados
%   Uso las funciones rayleigh_dist y theta_dist para encontrar valores
%   para radio y angulo de las muestras. Dev
ray1 = rayleigh_dist(1,muestras);
ray2 = rayleigh_dist(sigma2, muestras);
thet = theta_dist(muestras);
x = sigma1*ray1.*(cos(thet)) + mean1;
y = sigma2*ray1.*sin(thet) + mean2;

end

