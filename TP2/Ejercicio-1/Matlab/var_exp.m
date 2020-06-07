function [ exp_var ] = var_exp( functions, fun_quant,t)
%VAR_EXP Varianza experimental de arreglo de muestras
% functions , fun_quant = arreglo y tamano de funciones muestra
% t = valor de x en donde se quiere buscar la varianza del
%           ensamble
%Para calcular la varianza experimental precisamos de la media
%experimental y del valor cuadratico medio
exp_meansqtr = 0;   %inicializo en 0
exp_mean = expected_value(functions, fun_quant,t);
%Calculo del valor cuadratico medio experimental
for i=1:fun_quant 
    exp_meansqtr = exp_meansqtr + (1/fun_quant)*(functions{i}(t))^2;
end

exp_var = exp_meansqtr - (exp_mean)^2;

end