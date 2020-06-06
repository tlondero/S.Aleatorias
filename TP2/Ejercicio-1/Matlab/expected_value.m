function [ exp_mean ] = expected_value( functions, fun_quant,x_value)
%EXPECTED_VALUE Valor esperado experimental de arreglo de muestras
% functions , fun_quant = arreglo y tamano de funciones muestra
% x_value = valor de x en donde se quiere buscar valor esperado del
%           ensamble
exp_mean = 0;%inicializo en 0
for i=1:fun_quant %se puede usar size(functions) pero me da fiaca
    %1/fun_quant deberia ser la probabilidad de cada funcion del ensamble
    exp_mean = exp_mean + (1/fun_quant)*functions{i}(x_value);
end
end
