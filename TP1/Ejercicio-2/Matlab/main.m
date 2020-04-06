function [X, Y2, meanX, meanY, A, Ainv, sigX, sigY] = main(mean1, mean2, sigx1, sigx2, corr, samples)

% 1) Creamos las V.A. correspondientes al vector Y.
[y1, y2] = genX(sigx1, sigx2, samples);
Y = [y1; y2]; %Prolijidad/Sintaxis.

%Creamos el vector media de X y su matriz de covarianza sigma X.
meanX = [mean1; mean2];
sigX = [sigx1*sigx1 corr*sigx1*sigx2; corr*sigx1*sigx2 sigx2*sigx2];

%Ahora que tenemos todo, podemos calcular los valores de X. "eig" nos devuelve los autovectores ya normalizados.
[A, sigY] = eig(sigX);

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