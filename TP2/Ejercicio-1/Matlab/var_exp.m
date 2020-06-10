function [ exp_var ] = var_exp(cant_muestras, muestras)
%VAR_EXP Varianza experimental de arreglo de muestras
%cant_muestras = la cantidad total de valores experimentales
% muestras = es el vector de las funciones muestras
% evaluadas en un instante t
%Para calcular la varianza experimental precisamos de la media
%experimental 

exp_var = 0;   %inicializo en 0
%Calculo la media experimental
exp_mean = expected_value(cant_muestras, muestras);

%Estimamos la varianza experimental
for i=1:cant_muestras 
    exp_var = exp_var + (1/cant_muestras)*(muestras(i)- exp_mean)^2;
end

end


