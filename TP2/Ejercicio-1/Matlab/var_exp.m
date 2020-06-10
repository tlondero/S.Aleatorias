function [ exp_var ] = var_exp(cant_muestras, muestras)
%VAR_EXP Varianza experimental de arreglo de muestras
% cant_muestras, muestras = arreglo y tamano de funciones muestra
%Para calcular la varianza experimental precisamos de la media
%experimental 
exp_var = 0;   %inicializo en 0
exp_mean = expected_value(cant_muestras, muestras);
%Estimamos la varianza experimental
for i=1:cant_muestras 
    exp_var = exp_var + (1/cant_muestras)*(muestras(i)- exp_mean)^2;
end

end