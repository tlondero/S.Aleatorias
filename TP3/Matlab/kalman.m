function xhat = kalman(z, Phi, H, R, Q)

% z Measurement signal              m observations X # of observations
% Phi State transition model        n X n, n = # of state values
% H Observation model               m X n
% R Covariance of observation noise m X m
% Q Covariance of process noise     n X n

m = size(H, 1);	%Number of sensors
n = size(H, 2);	%Number of state values
numobs = size(z, 2);	%Number of observations
xhat = zeros(n, numobs);	%Observation


%Initialize P, I
P = ones(size(Phi));
I = eye(size(Phi));

%Kalman Filter
for k = 2:numobs
    %Predict
    xhat_acotado=xhat(:,k-1);
    
    xhat(:,k) = Phi*xhat_acotado;	%Shamugan 7.133 pag 433
    P = Phi*P*Phi' + Q;	%Borwn picture 4.1 pag 147
    
    %Update
    num = P*H';
    den = (H*P*H' + R);
    K = num/den;
    P = (I - K*H)*P;
    xhat(:,k) = xhat(:,k) + K*(z(:,k) - H*xhat(:,k));
end
