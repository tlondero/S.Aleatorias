function [autocorr] = autocorr_exp(cant_muestras, muestras_t1, muestras_t2)
%AUTOCORR_EXP autocorrelacion experimental entre dos instantes de tiempo
%t1 y t2 
%cant_muestras = la cantidad total de valores experimentales
% muestras_t1, muestras_t2 = son los vectores de las funciones muestras
% evaluados en los instantes t1 y t2 respectivamente
%Para calcular la autocorrelacion se estima el valor esperado del
% producto entre los valores que adquieren las funciones muestra en los
% instantes t1 y t2 promediando

autocorr = 0;   %inicializo en 0

for i=1:cant_muestras 
    autocorr =autocorr+(1/cant_muestras)*(muestras_t1(i))*(muestras_t2(i));
end

end