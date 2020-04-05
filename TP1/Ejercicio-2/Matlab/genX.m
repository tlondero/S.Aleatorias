function [x1,x2] = genX( sig1, sig2, samples )
%BIVANOCORR 2 vectores de muestras con valores dist normal no correlacionados
%   Uso las funciones rayleigh_dist y theta_dist para encontrar valores
%   para radio y angulo de las muestras. Dev
ray = rayleigh_dist(1, samples); % (!) Problema: Si tenemos que usar el mismo ray para ambas, ¿Como aplicamos las dos varianzas?
thet = theta_dist(samples);
x1 = ray.*(cos(thet));
x2 = ray.*sin(thet); 
end

