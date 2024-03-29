clc
clear
close all
fprintf('Welcome to GT1 matlab script for Kalman filtering\r\n');

%Constants usefull to alter the behaviour of the script
kmax=9;%Value of P
SAMPLES=100;
LOGSPACE_LEN = 10;

%Buffers for variables.
R_vars_buffer=logspace(-2,2,LOGSPACE_LEN);%diferent values for the variance of the measurment
error_improvement = zeros(1,LOGSPACE_LEN);
mse_measure_b=zeros(1,kmax);
mse_filter_b=zeros(1,kmax);

%%actual script
x=load('h06g1.dat')';%loads the sample vector

xs=x(1:SAMPLES);%gets a subarray to make it faster to process, if desired SAMPLES can be changed to a a value between 1 and size(x)

for j = 1:LOGSPACE_LEN%For each Variance

    for i = 1:kmax%For every p
        
        Rxxnp = Rnp(x,i+1);%Estimate the  Autocorrelation function using a non polarized estimator
        rxxnp = Rxxnp./Rxxnp(1); %Normalize it
        
        if(j==1 && i==kmax)
            [phikknp, phiv, phiVarn] = cpar(rxxnp, i+1,1);%Obtain the partial correlation coeffients by solving the Yule Walker equation.
        else
            [phikknp, phiv, phiVarn] = cpar(rxxnp, i+1,0);%Obtain the partial correlation coeffients by solving the Yule Walker equation.      
        end
      
        % Kalman matrices.
        PHI = [phiv';[eye(i-1) zeros(i-1,1)]];%Phi matrix for the Kalman filter, also known as the State transition model
        %%The first row is the AR coefficients, the other is the Identity
        %%matrix
        H = zeros(i,i);% Observation model
        H(1,1)=1;
                
        varX=var(x);
        varNoise= var(x)*(1-dot(phiVarn(i,1:i),rxxnp(2:i+1)));
        Q=zeros(i);
        Q(1,1)=varNoise;%Create the Covariance of process noise
        
        R=eye(i)*R_vars_buffer(j); %R Covariance of observation noise
        
        z =  xs + sqrt(R(1,1)) * randn(size(xs)); %Measurement  of the signal
        z=make_extended(z,i);%Extends the measurment vector to make it fit for the AR model.
        
        xhat = kalman(z, PHI, H, R, Q);%With the Matrices defined, apply the Kalman filter to the sequence
        
        Yhat= (H*xhat);%Apply the observation matrix to obtain the i
        Yhat=Yhat(1,:);
        zinput=z(1,:);
       
        measurement_error = (xs-zinput).^2;
        filter_error = (xs-Yhat).^2;
        mse_measure_b(i) = mean(measurement_error);
        mse_filter_b(i) = mean(filter_error);
        
        if (i == kmax)
            error_improvement(j) = mean((mse_measure_b - mse_filter_b)*100/mse_measure_b);
        end
        
        if(i==kmax && j==LOGSPACE_LEN-4)
            hold on
            plot(zinput, 'g')
            plot(xs, 'k')
            plot(Yhat, 'r')

            legend({'Measurement','Input', 'Estimated'})
            xlabel('Samples [n]');
            ylabel('Amplitude ');
            title(sprintf(' $$\\sigma_v^2$$ = %.4f ~ p = %i ~ $$MSE_{Input-Measure}$$=%.4f ~ $$MSE_{Input-Filter}$$=%.4f', R_vars_buffer(j), i,mse_measure_b(i),mse_filter_b(i)), 'interpreter', 'latex');
            suptitle('Kalman Filtering Stages');
            grid on;
            hold off
            if(j ~= LOGSPACE_LEN)
                figure();
            end

        end
    end
end

    semilogx(R_vars_buffer,error_improvement);
    grid on;
    title('Mejora porcentual del error cuadratico medio');
    xlabel(sprintf('$$\\sigma_v^2$$'),'interpreter', 'latex');
    ylabel('MSE %');

function xtended = make_extended(x,k)
    size_ = size(x);
    size_=size_(2);
    xtended=zeros(k,size_);
   for i = 1:k
       xtended(i,:)= [zeros(1,i-1) x(1:size_-(i-1))];
       %El extendido con I maneje todo
   end
end
