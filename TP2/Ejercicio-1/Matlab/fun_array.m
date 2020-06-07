function [ funciones ] = fun_array()

%FUN_ARRAY Funcion que devuelve n muestras de un proceso aleatorio
%fun_quant =  cantidad de muestras que quiero en el arreglo.

funciones = {}; % Nose por que pero tiene que ser un arreglo de este tipo
% for i=1:fun_quant
%     theta = unifrnd(0,2*pi) %reemplazar por variable aleatoria y ditribucion acorde
%     f = @(x)[sin(x+theta)]; %Reemplazar por modelo de funcion del ensamble acorde
%     funciones{i} = f;
% end

f1 = @(t)[6];
funciones{1} = f1;
  f2 = @(t)[3*sin(t)];
funciones{2} = f2;
f3 = @(t)[-3*sin(t)];
funciones{3} = f3;
f4 = @(t) [3*cos(t)];
funciones{4} = f4;
f5 = @(t)[-3*cos(t)];
funciones{5} = f5;
f6 = @(t)[-6];
funciones{6} = f6;


end

