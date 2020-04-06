function [X, Y2, meanX, meanY, A, A0, sigX, sigY] = main(mean1, mean2, sigx1, sigx2, corr, samples)

% 1) Creamos las V.A. correspondientes al vector Y.
[y1, y2] = genX(sigx1, sigx2, samples);
Y = [y1; y2]; %Prolijidad/Sintaxis.

%Creamos el vector media de X y su matriz de covarianza sigma X.
meanX = [mean1; mean2];
sigX = [sigx1*sigx1 corr*sigx1*sigx2; corr*sigx1*sigx2 sigx2*sigx2];

%Ahora que tenemos todo, podemos calcular los valores de X. "eig" nos devuelve los autovectores ya normalizados.
[A0, sigY] = eig(sigX);

A = [A0(2,:);A0(1,:)]; % Invierto el orden de las columnas, como debería ser realmente.
A(1,:) = A(1,:) * (-1); % Le cambio el signo a la matriz... Por algun motivo es necesario.
A(2,:) = A(2,:) * (-1);

meanY = A*meanX; % Esto es una ecuación del libro y ya. 
Y2 = Y + meanY;
Ainv = transpose(A); %Matriz ortogonal -> Inversa = Transpuesta
X = Ainv*Y2;

figure(1)
axis equal
plot(Y2(1,:),Y2(2,:),'.');
figure(2)
axis equal
plot(X(1,:), X(2,:),'.');

end