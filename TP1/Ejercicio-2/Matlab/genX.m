function [x1,x2] = genX( sig1, sig2, samples )
%genX Recibe los desvios para generar un vector bidimensional de muestras 
%   con valores dist normal no correlacionados
%LLama las funciones rayleigh_dist y theta_dist para generar las variables
% gaussianas
%Devuelve dos vectores con distribucion gaussiana
ray = rayleigh_dist(samples);   
thet = theta_dist(samples);
%genero las gaussianas
x1 = sig1*ray.*(cos(thet));
x2 = sig2*ray.*sin(thet); 
end

