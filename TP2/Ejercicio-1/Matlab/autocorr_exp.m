function [ autocorr ] = autocorr_exp(cant_muestras, muestras_t1, muestras_t2)
%AUTOCORR_EXP autocorrelacion experimental entre dos instantes de tiempo
%t1 y t2 
%functions , fun_quant = arreglo y tamano de funciones muestra
%Para calcular la autocorrelacion se calcula el valor esperado del
% producto entre los valores que adquieren las funciones muestra en los
% instantes t1 y t2

autocorr = 0;   %inicializo en 0

for i=1:cant_muestras 
    autocorr = autocorr+(1/cant_muestras)*(muestras_t1(i))*(muestras_t2(i));
end

end