function [  ] = simulacion( cantidad_muestras)
%SIMULACION EJERCICIO 1
%   Cada Muestra tiene la forma [ x(pi/2)
%                                 x(pi/4)
%                                 x(pi)
%                                 x(2*pi)]

% Genero un vector que contiene a las funciones miembro del proceso
ensamble = fun_array();

% Genero muestras de valores posibles del proceso a ciertos tiempos
for i=1:cantidad_muestras
    indice_funcion =  randi(6); %Tiro el dado que determina funcion del ensamble
    muestra_funcion =[ensamble{indice_funcion}(pi/2)  %Muestreo funcion correspondiente
                      ensamble{indice_funcion}(pi/4) %En vez de evaluar la funcion solo, ya se podria hacer el producto necesario
                      ensamble{indice_funcion}(pi)   % avisame si queres que lo cambie
                      ensamble{indice_funcion}(2*pi)
                      ]
   muestras_totales(:,i) = muestra_funcion;
end

%Ploteo valores de funcion evaluada en t = pi/2 para multiples experimentos
plot(muestras_totales(1,:),'r*');

% Calculos de Valor esperado y demas

expected_value(cantidad_muestras,muestras_totales(1,:))

end
