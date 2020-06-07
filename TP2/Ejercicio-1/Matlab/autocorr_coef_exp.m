function [ coef_auto ] = autocorr_coef_exp( functions, fun_quant,t1, t2)
%COEF_AUTO autocorrelacion experimental entre dos instantes de tiempo
%t1 y t2 
%functions , fun_quant = arreglo y tamano de funciones muestra
%Para calcular el coeficiente de autocorrelacion debemos calcular la
%la autocorrelacion en (t1,t2), los valores esperados en t1 y t2
%y por ultimo, la autocorrelacion en (t1,t1) y la autocorrelacion en
%(t2,t2)

autocorr = autocorr_exp(functions, fun_quant,t1, t2);
exp_mean_t1 = expected_value(functions, fun_quant,t1);
exp_mean_t2 = expected_value(functions, fun_quant,t2);

autocorr_t1 = autocorr_exp(functions, fun_quant,t1, t1);
autocorr_t2 = autocorr_exp(functions, fun_quant,t2, t2);

coef_auto=(autocorr-(exp_mean_t1*exp_mean_t2))/sqrt(autocorr_t1*autocorr_t2);

end