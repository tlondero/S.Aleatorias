clc
clear

R_VARIANCE=10;
kmax=9;

SAMPLES=100;

x=load('h08g1.dat')';

 
x_extended=x(1:SAMPLES);

%i=kmax;
for i = 1:kmax
%         %Creamos Rxxs (estimaciones)
fprintf('Start of %i\r\n',i);
Rxxnp = Rnp(x,i+1);
rxxnp = Rxxnp./Rxxnp(1);


[phikknp, phiv, phiVarn] = cpar(rxxnp, i+1);%Coeficiente de correlacion parcial.


PHI = [phiv';[eye(i-1) zeros(i-1,1)]];

%        PHI = [0  1 ;0.5  -0.5];
% Observation model
H = zeros(i,i);
H(1,1)=1;

% Process noise covariance
varx=var(x);

phivarnCol=phiVarn(i,1:i);

rxxcol=rxxnp(2:i+1);

varN= var(x)*(1-dot(phivarnCol',rxxcol));
Q=zeros(i);
Q(1,1)=varN;

R=eye(i)*R_VARIANCE; %%VER

xn = x_extended;% + w;
z =  xn + sqrt(R(1,1)) * randn(size(xn));
z=make_extended(z,i);


xhat = kalman(z, PHI, H, R, Q);

Yhat= (H*xhat);
Yhat=Yhat(1,:);
zinput=z(1,:);

hold on
plot(zinput, 'g')
plot(xn, 'k')
plot(Yhat, 'r')

legend({'Measurement','Input', 'Estimated'})
title(sprintf('Salida del filtro para $$\\sigma_v^2$$ = %.2f y p = %i', R_VARIANCE, i), 'interpreter', 'latex');
grid on;
hold off
if(i ~= kmax)
figure();
end
err_input = (xn-zinput).^2;
err_output = (xn-Yhat).^2;
mse_input=mean(err_input);
mse_output=mean(err_output);
fprintf('MSE Data-Measure %.2f \r\n',mse_input);
fprintf('MSE Data-Filter %.2f \r\n',mse_output);
fprintf('End of %i\r\n',i);
end

function plotsigs(pos, sig1, sig2, sig1label)
subplot(3,1,pos)
hold on
plot(sig1, 'k')
plot(sig2, 'r')
legend({sig1label, 'Estimated'})
    xlim([0 100])
    ylim([-10 10])

hold off
end

function plotsigsrms(label, pos, x, xhat)
plotsigs(pos, x, xhat, 'Actual')
title(sprintf('%s: RMS error = %f', label, sqrt(sum((x-xhat).^2)/length(x))))
end

function xtended = make_extended(x,k)
    size_ = size(x);
    size_=size_(2);
    xtended=zeros(k,size_);
   for i = 1:k
       xtended(i,:)= [zeros(1,i-1) x(1:size_-(i-1))];
       %aca tengo que hacer que haga el extendido solo cosa de que sol con
       %I maneje todo
   end
end
