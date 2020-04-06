function [x1,x2] = genX( sig1, sig2, samples )
%BIVANOCORR 2 vectores de muestras con valores dist normal no correlacionados
%   Uso las funciones rayleigh_dist y theta_dist para encontrar valores
%   para radio y angulo de las muestras. Dev
ray = rayleigh_dist(samples);
thet = theta_dist(samples);
x1 = sig1*ray.*(cos(thet));
x2 = sig2*ray.*sin(thet); 
end

