function [ exp_mean ] = expected_value( cant_muestras, muestras)
%EXPECTED_VALUE Valor esperado experimental de arreglo de muestras
%cant_muestras = la cantidad total de valores experimentales
% muestras = es el vector de las funciones muestras
% evaluadas en un instante t

exp_mean = 0;%inicializo en 0

for i=1:cant_muestras 
    %promediamos el valor esperado
    exp_mean = exp_mean + (1/cant_muestras)*(muestras(i));
end

end
