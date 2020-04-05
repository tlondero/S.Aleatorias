function main(mean1, mean2, sigx1, sigx2, corr, samples)

% 1) Creamos las V.A. correspondientes al vector X.
[x1, x2] = genX(sigx1, sigx2, samples);
X = [x1; x2]; %Prolijidad/Sintaxis.

plot(x1, x2,'.'); % Puse esto para probar. Fun fact: Si pones solo x1 o x2, es todo muy turbio, pero si pones ambas se ve bonito como debería.
%Igual, creo que está bien.


%Creamos el vector media de X y su matriz de covarianza sigma X.
meanX = [mean1; mean2];
sigX = cov(x1,x2); % "C = covar(A,B) - If A and B are vectors of observations with equal length, cov(A,B) is the 2-by-2 covariance matrix."
% (!) A mi me tira error, porque me dice que necesito una libreria que está
% en la versión paga. Ni idea. No logro hacer que ande, pero teóricamente
% esto es correcto.


%Ahora que tenemos todo, podemos calcular los valores de Y. "eig" nos devuelve los autovectores ya normalizados.
[A, sigY] = eig(sigX);
meanY = A*meanX; % Esto es una ecuación del libro y ya. 
% (!) En el libro, en el ejercicio 2.46 usaba meanX = 0 (el vector nulo). ¿Era por algo en particular o podemos poner lo que nos plazca? 


Y = A*X;
%Y = [y1; y2] % Prolijidad/sintaxis.
plot(Y(1,:),Y(2,:),'.')
% (!) Teóricamente, siguiendo la lógica del ejercicio 2.46 pasamos de un vector
% con variables correlacionadas a otro con variables sin relacionar. Ahora
% bien, ¿Donde entra en juego el parámetro de la correlación?
% Sabemos que p = sigmaXY / (sigmaX*sigmaY). ¿Habrá que hacer algo con
% esto? Otra cosa relevante no encuentro, pero soy tonto y son las 7:20am.

end