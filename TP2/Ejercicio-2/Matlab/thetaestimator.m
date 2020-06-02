function [optimustheta] = thetaestimator(x)

    sizeOfArr = size(x);
    errorTable = zeros(1,sizeOfArr(2)); % Creo un arreglo del tamaño del vector X. Con esto, trabajaré a prueba y error.
    theta = 0;
    totalErrorPerTheta = zeros(2,1+99*2) %El +1 es por el 0.
    lengthOfTotalError = size(totalErrorPerTheta);
    for m = -99:99
        errorTable = zeros(1, sizeOfArr(2))
        theta = m/100;
        
        errorTable(1) = x(1);
        
        for n = 2:sizeOfArr(2)
            errorTable(n) = x(n) - theta*errorTable(n-1);
        end
        
        for l = 1:sizeOfArr(2)
        totalErrorPerTheta(1, m+100)= totalErrorPerTheta(1,m+100) + errorTable(l)*errorTable(l); %Sumo el cuadrado de cada componente del error.
        %El 100 es para desplazar el m a un rango apropiado. Ej: Si m = -99 -> m + 100 = 1.
            
        end
        totalErrorPerTheta(2, m+100) = m/100;
    end
    
    [M,P] = min(totalErrorPerTheta(1,1:lengthOfTotalError(2))); %Recupero el mínimo y su índice.
    optimustheta = totalErrorPerTheta(2,P);

end

% y = [0.5,0.99,-0.48,-0.2,-1.31,0.81,1.82,2.46,1.07,-1.29]
%Esto es lo que uso para probar. Es el ejemplo 9.7 del libro. Me da bien, devuelve 0.48. Asumo que la data provista también me da bien
%pero me resulta raro que me quede -0.99.
    