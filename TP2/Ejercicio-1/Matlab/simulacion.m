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
    %Muestreo funcion correspondiente
    muestra_funcion =[ensamble{indice_funcion}(pi/2)  %t1 = pi/2
                      ensamble{indice_funcion}(pi/4)  %t2 = pi/4
                      ensamble{indice_funcion}(pi)    %t3 = pi
                      ensamble{indice_funcion}(2*pi)  %t4 = 2pi
                      ];
   muestras_totales(:,i) = muestra_funcion; %#ok<AGROW>
end

%Ploteo valores de funcion evaluada en t = pi/2 para multiples experimentos
figure (1);
ejex = linspace(1,cantidad_muestras,cantidad_muestras);
scatter(ejex, muestras_totales(1,:));

%Ploteo valores de funcion evaluada en t = pi/4 para multiples experimentos
figure(2);
ejex = linspace(1,cantidad_muestras,cantidad_muestras);
scatter(ejex, muestras_totales(2,:));

%Estimamos la media en t1= pi/2
exp_mean_t1 = expected_value(cantidad_muestras,muestras_totales(1,:));

%Estimamos la varianza en t2= pi/2
var_t1 = var_exp(cantidad_muestras,muestras_totales(1,:));

%Estimamos la autocorrelacion en t1= pi/2 y t2= pi/4
autocorr_t1_t2 = autocorr_exp(cantidad_muestras,muestras_totales(1,:),muestras_totales(2,:));

%Estimamos el coeficiente de autocorrelacion en t3= pi y t4= 2pi
coef_autocorr_t3_t4 = autocorr_coef_exp(cantidad_muestras,muestras_totales(3,:),muestras_totales(4,:));

end
