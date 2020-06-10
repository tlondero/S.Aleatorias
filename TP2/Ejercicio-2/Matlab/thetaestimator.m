function [optimustheta, M] = thetaestimator(x, cantDec)
   
    %Con cantDec = 2 pasa a tardar +40 segundos, pero es mucho más preciso.
    cantElem = 10^cantDec - 1; %Cantidad de elementos por cada lado
    
    sizeOfArr = size(x);
    errorTable = zeros(1,sizeOfArr(2)); % Creo un arreglo del tamaño del vector X. Con esto, trabajaré a prueba y error.
    theta = 0;
    totalErrorPerTheta = zeros(1+cantElem*2,1+cantElem*2); %El +1 es por el 0.
    lengthOfTotalError = size(totalErrorPerTheta);
    thetaindex = zeros(2,1+cantElem*2);
    
    for n = -(cantElem):(cantElem)
        theta21 = n/(cantElem+1);
        for m = -cantElem:cantElem
            errorTable = zeros(1, sizeOfArr(2));
            theta22 = m/(cantElem+1);
        
            errorTable(1) = x(1);
            errorTable(2) = x(2) - theta21*errorTable(1);
            for l = 3:sizeOfArr(2)
               errorTable(l) = x(l) - theta21*errorTable(l-1) - theta22*errorTable(l-2);
            end
        
            for j = 1:sizeOfArr(2)
            totalErrorPerTheta(n+(cantElem+1), m+(cantElem+1)) = totalErrorPerTheta(n+(cantElem+1),m+(cantElem+1)) + errorTable(j)*errorTable(j); %Sumo el cuadrado de cada componente del error.
            %El 100 es para desplazar el m a un rango apropiado. Ej: Si m = -99 -> m + 100 = 1.
            
            end
        end
    end
    
    for n = -cantElem:cantElem
        thetaindex(1, n+(cantElem+1)) = n/(cantElem+1);
        thetaindex(2, n+cantElem+1) = n/(cantElem+1);
    end
    
    [M,I] = min(totalErrorPerTheta(:)); %Recupero el mínimo y su índice.
    I_col = floor(I/(cantElem*2+1)) + 1;
    I_row = I - (I_col-1)*(cantElem*2+1);
    optimustheta = [thetaindex(2, I_row), thetaindex(1,I_col)]; %Primero devuelve el theta21 y luego el 22.
end

%{ Usé el ejemplo del libro para est. Me da un poco distinto, pero revisé los valores como 8 veces y están bien.
%y = [  1.102,     0.699,   2.336,     1.026,    -0.206,  1.486,     0.768,   0.69,     -0.001,    -1.150, -0.273,    -0.941,   1.746,     0.3,      -1.494,  0.192,     0.023,   1.633,     1.188,    -2.243, -0.961,    -0.77,    0.535,     1.263,     0.377, -0.48,      0.091,   1.007,     1.169,     0.346, -0.052,    -0.186,   0.033,     0.106,     1.402,  0.879,    -1.49,    1.031,     1.127,     0.824,-0.478,    -1.707,   0.877,     1.257,     0.83,-1.534,    -1.411,   0.468,    -0.066,    -1.56,-1.803,    -1.1,     0.274,     2.362,     1.834, 0.7780 ,   1.1720, -0.5030,   -0.100,    -1.527,-2.019,    -1.498,  -2.259,    -1.272,    -0.033,-0.096,    2.723 ,-0.243,    -2.256,    -0.462,  0.509,    -1.240,  -0.194,     0.217,     0.899, -0.683,    -0.621,   0.001,     0.978,     0.808, 0.419,     0.667,  -0.694,     0.355,     1.121, -0.130,    -0.895,  -1.366,    -0.247,     0.7410, 0.0470,   -0.662,  -1.2250,   -0.988,  -0.3130, 0.3120,   -0.7470, -1.8160,   -1.898,    -1.5920]
%}


    