function [ ] = simulacion_al_cuadrado(  )
%SIMULACION_AL_CUADRADO La use para plotear valor esperado en funcion de
%cantidad de muestras

for i=1:300
    y(i) = simulacion(20*i);
    x(i) = 20*i;
end

plot(x,y,'r*');

