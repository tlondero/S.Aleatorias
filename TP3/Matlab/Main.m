
DEBUG =    0;

kmax=20;
if(DEBUG==1)
x=( sin(5*linspace(0,1,32768)*pi));
else
x=load('h08g1.dat')';
end
 
x_extended= make_extended(x,kmax);
fprintf('Size of X')
size(x_extended)
i=kmax;
%         %Creamos Rxxs (estimaciones)
Rxxnp = Rnp(x,i+1);
rxxnp = Rxxnp./Rxxnp(1);


phikknp = cpar(rxxnp, i+1);%Coeficiente de correlacion parcial.
phiv =phikknp(1:i);


A = [phiv;[eye(i-1) zeros(i-1,1)]];
fprintf('Size of A')
size(A)
%        A = [0  1 ;0.5  -0.5];
% Observation model
C1 = zeros(i,i);
C1(1,1)=1;
fprintf('Size of C')
size(C1)
% Process noise covariance
Q = .005 * eye(i);
fprintf('Size of Q')
size(Q)
R=eye(i)*1.65;
fprintf('Size of R')
size(R)
w = sqrt(Q) * randn(size(x_extended));

xn = x_extended + w;

z =  xn + sqrt(R(1,1)) * randn(size(xn));
fprintf('Size of z')
size(z)

xhat = kalman(z, A, C1, R, Q);

Yhat= (C1*xhat);
Yhat=Yhat(1,:);
zinput=z(1,:);
xn=xn(1,:);
plotsigs(1, zinput, Yhat, 'Measure')
title('Signal cleanup')
%         % Plot estimate and actual values
plotsigsrms('Signal', 2, xn(1,:), Yhat)
%    end
plotsigsrms('Measurment', 3, zinput, Yhat)
%    end



function plotsigs(pos, sig1, sig2, sig1label)
subplot(3,1,pos)
hold on
plot(sig1, 'k')
plot(sig2, 'r')
legend({sig1label, 'Estimated'})

    ylim([-5 5])

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
