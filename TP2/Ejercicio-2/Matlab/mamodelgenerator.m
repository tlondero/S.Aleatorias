function [estx] = mamodelgenerator(x)

sizeOfX = size(x);

[thetas, min] = thetaestimator(x,1);

theta21 = thetas(1); %Pongo cada theta en una variable con su subindice en el nombre
theta22 = thetas(2);

varN = min/(sizeOfX(2) - 2); %Calculo la varianza de e(n) por fórmula (pág 603)

wgn = sqrt(varN)*randn([1,4096]); %Genero e(n). Media 0 y varianza ya calculada (La cual aplico multiplicando por el desvío estandar),

estx = zeros(1, 4096); %Genero una muestra de X estimada a partir del modelo. Aca creo el vector.

estx(1) = wgn(1)
estx(2) = wgn(2) - theta21*wgn(1);
for n = 3:10000
    estx(n) = wgn(n) + wgn(n-1)*theta21 + wgn(n-2)*theta22; %Aca lo completo, aplicando el modelo.
end
%Se devuelve el modelo.
end
