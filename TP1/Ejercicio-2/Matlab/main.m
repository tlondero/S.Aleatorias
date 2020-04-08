function [X, Y2] = main(mean1, mean2, sigx1, sigx2, corr, samples)

%1) Creamos el vector media de X y su matriz de covarianza sigma X.
meanX = [mean1; mean2];
sigX = [sigx1*sigx1, corr*sigx1*sigx2; corr*sigx1*sigx2, sigx2*sigx2];

%Ahora calculamos los avas de X. "eig" nos devuelve los autovectores 
%ya normalizados.
[A0, sigY0] = eig(sigX);

%Invierto el orden de las filas, que por algun motivo si no se realiza
% se invierten los ejes luego.
A = [A0(2,:);A0(1,:)]; 
sigY = [sigY0(2,2), 0;0, sigY0(1,1)];

% Generamos Y, siendo sus varianzas los autovalores de sigma X. y su 
%vector de medias meanY
[y1, y2] = genX(sqrt(sigY(1,1)), sqrt(sigY(2,2)), samples); 
Y = [y1; y2];
meanY = A*meanX; % Esto es una ecuacion del libro y ya. 

%generamos el vector aleatorio Y2 con media distinta de 0
Y2 = Y + meanY; 
AT = A'; %Matriz ortogonal -> Inversa = Traspuesta

 %Vector aleatorio X gaussiano Bivariable
X = AT*Y2; 

%Ploteamos el vector Y2 incorrelacionadas
figure(1)
plot(Y2(1,:),Y2(2,:),'.');
axis equal

%ploteamos el vector X ya correlacionadas
figure(2)
plot(X(1,:), X(2,:),'.');
axis equal

end