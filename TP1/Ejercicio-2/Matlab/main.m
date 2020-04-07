function [X, Y2, meanX, meanY, A, Ainv, sigX, sigY] = main(mean1, mean2, sigx1, sigx2, corr, samples)

%1) Creamos el vector media de X y su matriz de covarianza sigma X.
meanX = [mean1; mean2];
sigX = [sigx1*sigx1, corr*sigx1*sigx2; corr*sigx1*sigx2, sigx2*sigx2];

%Ahora que tenemos eso, podemos calcular los valores de X. "eig" nos devuelve los autovectores ya normalizados.
[A0, sigY0] = eig(sigX);

A = [A0(2,:);A0(1,:)]; % Invierto el orden de las filas, que por algun motivo si no lo hago me invierte los ejes luego.
sigY = [sigY0(2,2), 0;0, sigY0(1,1)];

[y1, y2] = genX(sigY(1,1), sigY(2,2), samples); % Generamos Y, siendo sus varianzas los autovalores de sigma X.
Y = [y1; y2]; %Prolijidad/Sintaxis.

meanY = A*meanX; % Esto es una ecuación del libro y ya. 
Y2 = Y + meanY;
Ainv = inv(A); %Matriz ortogonal -> Inversa = Transpuesta
X = Ainv*Y2;

figure(1)
plot(Y2(1,:),Y2(2,:),'.');
axis equal
figure(2)
plot(X(1,:), X(2,:),'.');
axis equal
end