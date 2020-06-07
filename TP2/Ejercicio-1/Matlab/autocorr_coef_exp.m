function [ coef_auto ] = autocorr_coef_exp( functions, fun_quant,t1, t2)
%AUTOCORR_EXP autocorrelacion experimental entre dos instantes de tiempo
%t1 y t2 
%functions , fun_quant = arreglo y tamano de funciones muestra
%Para calcular la autocorrelacion se calcula el valor esperado del
% producto entre los valores que adquieren las funciones muestra en los
% instantes t1 y t2

autocorr = autocorr_exp(functions, fun_quant,t1, t2);
exp_mean_t1 = expected_value(functions, fun_quant,t1);
exp_mean_t2 = expected_value(functions, fun_quant,t2);

autocorr_t1 = autocorr_exp(functions, fun_quant,t1, t1);
autocorr_t2 = autocorr_exp(functions, fun_quant,t2, t2);

coef_auto=(autocorr-(exp_mean_t1*exp_mean_t2))/sqrt(autocorr_t1*autocorr_t2);

end