function [ exp_mean ] = expected_value( cant_muestras, muestras)
%EXPECTED_VALUE Valor esperado experimental de arreglo de muestras
% functions , fun_quant = arreglo y tamano de funciones muestra
% x_value = valor de x en donde se quiere buscar valor esperado del
%           ensamble
exp_mean = 0;%inicializo en 0
for i=1:cant_muestras %se puede usar size(functions) pero me da fiaca
    %1/fun_quant deberia ser la probabilidad de cada funcion del ensamble
    exp_mean = exp_mean + (1/cant_muestras)*(muestras(i));
end
end
