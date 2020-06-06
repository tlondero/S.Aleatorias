function [ funciones ] = fun_array( fun_quant)

%FUN_ARRAY Funcion que devuelve n muestras de un proceso aleatorio
%fun_quant =  cantidad de muestras que quiero en el arreglo.

funciones = {}; % Nose por que pero tiene que ser un arreglo de este tipo
for i=1:fun_quant
    theta = unifrnd(0,2*pi) %reemplazar por variable aleatoria y ditribucion acorde
    f = @(x)[sin(x+theta)]; %Reemplazar por modelo de funcion del ensamble acorde
    funciones{i} = f;
end

end

