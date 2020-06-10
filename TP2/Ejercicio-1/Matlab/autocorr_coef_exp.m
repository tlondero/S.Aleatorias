function [ coef_auto ] = autocorr_coef_exp(cant_muestras, muestras_t1, muestras_t2)
%COEF_AUTO autocorrelacion experimental entre dos instantes de tiempo
%t1 y t2 
%cant_muestras  = la cantidad total de valores experimentales
%muestras_t1, muestras_t2 = son los vectores de las funciones muestras
%evaluados en los instantes t1 y t2 respectivamente
%Para calcular el coeficiente de autocorrelacion debemos calcular la
%la autocorrelacion en (t1,t2), los valores esperados en t1 y t2
%y por ultimo, la autocorrelacion en (t1,t1) y la autocorrelacion en
%(t2,t2)

autocorr = autocorr_exp(cant_muestras, muestras_t1, muestras_t2);
exp_mean_t1 = expected_value(cant_muestras,muestras_t1);
exp_mean_t2 = expected_value(cant_muestras, muestras_t2);

autocorr_t1 = autocorr_exp(cant_muestras, muestras_t1, muestras_t1);
autocorr_t2 = autocorr_exp(cant_muestras, muestras_t2, muestras_t2);

%Calculo del coeficiente de autocorrelacion
coef_auto=(autocorr-(exp_mean_t1*exp_mean_t2))/sqrt(autocorr_t1*autocorr_t2);

end

