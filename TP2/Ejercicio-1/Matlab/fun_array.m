function [ funciones ] = fun_array()
%FUN_ARRAY Funcion que devuelve n muestras de un proceso aleatorio

funciones = {}; 

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

