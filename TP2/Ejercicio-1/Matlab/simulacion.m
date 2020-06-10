function [exp_mean_t1,var_t1,autocorr_t1_t2,coef_autocorr_t3_t4] = simulacion(cantidad_muestras)
%SIMULACION EJERCICIO 1
%   Cada Muestra tiene la forma [ x(pi/2)
%                                 x(pi/4)
%                                 x(pi)
%                                 x(2*pi)]
%Devuelve el valor esperado en pi/2
% Genero un vector que contiene a las funciones miembro del proceso
ensamble = fun_array();

% Genero muestras de valores posibles del proceso a ciertos tiempos
for i=1:cantidad_muestras
    indice_funcion =  randi(6); %Tiro el dado que determina funcion del ensamble
    muestra_funcion =[ensamble{indice_funcion}(pi/2)  %Muestreo funcion correspondiente
                      ensamble{indice_funcion}(pi/4)
                      ensamble{indice_funcion}(pi)   
                      ensamble{indice_funcion}(2*pi)
                      ];
   muestras_totales(:,i) = muestra_funcion; %#ok<AGROW>
end

%Ploteo valores de funcion evaluada en t = pi/2 para multiples experimentos
ejex = linspace(1,cantidad_muestras,cantidad_muestras);
scatter(ejex, muestras_totales(1,:));

% Calculos de Valor esperado y demas

exp_mean_t1 = expected_value(cantidad_muestras,muestras_totales(1,:));

var_t1 = var_exp(cantidad_muestras,muestras_totales(1,:));

autocorr_t1_t2 = autocorr_exp(cantidad_muestras,muestras_totales(1,:),muestras_totales(2,:));

coef_autocorr_t3_t4 = autocorr_coef_exp(cantidad_muestras,muestras_totales(3,:),muestras_totales(4,:));

end
