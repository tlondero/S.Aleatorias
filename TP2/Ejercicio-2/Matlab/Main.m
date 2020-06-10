function [rxxp, rxxnp, phikkp, phikknp] = Main(x,kmax)

    %PUNTO 1
    
    %Creamos Rxxs (estimaciones)
    Rxxnp = Rnp(x,kmax); 
    Rxxp = Rp(x,kmax); 
    
    %Creamos rxxs (estimaciones)
    rxxnp = Rxxnp./Rxxnp(1);
    rxxp = Rxxp./Rxxp(1);
    
    aux_rxx = 1:1:kmax;
    aux_phi = 1:1:(kmax-1);
    
    %Ploteamos rxxs (estimaciones)
    hold on
    p1 = plot(aux_rxx, rxxnp, aux_rxx, rxxp);
    p1(1).LineWidth = 1.75;
    p1(2).LineWidth = 1.75;
    legend('No polarizado', 'Polarizado');
    title('r_{xx}');
    figure();
    %figure('$r_{xx}$ normalizado y no normalizado');
    
    %PUNTO 2
    
    %Creamos phikk
    phikknp = cpar(rxxnp, kmax);
    phikkp = cpar(rxxp, kmax);
    
    %Ploteamos phikk
    hold on
    p2 = plot(aux_phi, phikknp, aux_phi, phikkp);
    legend('No polarizado', 'Polarizado');
    p2(1).LineWidth = 1.75;
    p1(2).LineWidth = 1.75;
    title('\phi_{kk}');
    figure();
    
    
    %PUNTO 3 y 4
    %Debemos modelar X(n) a través de un Moving Average de orden 2.
    syms th21x th22x%%resuelvo el sistema de ecuaciones
    S= solve((round(rxxnp(2)*100)/100) *(th21x^2+th22x^2+1) == th21x*th22x+th21x, (round(rxxnp(3)*100)/100) *(th21x^2+th22x^2+1) == th22x);
    theta21v=vpa(S.th21x);
    theta22v= vpa(S.th22x);
    theta21= theta21v(1);%valor de theta 21
    theta22=theta22v(1);%valor de theta 22
    rxxCalc=  zeros(1, 128);
    rxxCalc(1)=(theta21*theta21+theta22*theta22+1)/(1+theta21^2+theta22^2);
    rxxCalc(2)= (theta21+theta21*theta22)/(1+theta21^2+theta22^2);
    rxxCalc(3)= theta22/(1+theta21^2+theta22^2);
    Varn = double((round(Rxxnp(3)*1000)/1000)./theta22);

    RxxCalc= rxxCalc*Varn ;
    
    %%Graficorxx estimaciones y analitico
    hold on
    p7 = plot(aux_rxx, rxxnp, aux_rxx, rxxp,aux_rxx,rxxCalc);
    p7(1).LineWidth = 1.75;
    p7(2).LineWidth = 1.75;
    legend('No polarizado', 'Polarizado','Anal�tico');
    title('r_{xx}');
    figure();
        %%GraficoRxx estimaciones y analitico
    hold on
    p7 = plot(aux_rxx, Rxxnp, aux_rxx, Rxxp,aux_rxx,RxxCalc);
    p7(1).LineWidth = 1.75;
    p7(2).LineWidth = 1.75;
    legend('No polarizado', 'Polarizado','Anal�tico');
    title('R_{xx}');
    figure();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %PERIODRIGRAMAS (PUNTO 5)
    
    %Periodigrama y plot
    FftPeriod = (abs(fft(x)).^2)./max(size(x));
    hold on
    p3 = plot(FftPeriod);
    p3(1).LineWidth = 1;
    title('Periodigrama calculado');
    figure();
    %%%punto 5

    
    
    
    %FFT de Rxxs (estimados)
    FftRxxnp=abs(fft([Rxxnp,fliplr(Rxxnp)]));
    FftRxxp=abs(fft([Rxxp,fliplr(Rxxp)]));
    fftTeo=fft([RxxCalc,fliplr(RxxCalc)]);
    fftTeo=abs(fftTeo);
    
    hold on
    p4 = plot( [1:length(FftRxxnp)].*length(FftPeriod)./length(FftRxxnp), FftRxxnp);
    p4(1).LineWidth = 1;
    p5 = plot( [1:length(FftRxxp)].*length(FftPeriod)./length(FftRxxp), FftRxxp);
    p5(1).LineWidth = 1;
    p6 = plot( [1:length(fftTeo)].*length(FftPeriod)./length(fftTeo), fftTeo);
    p6(1).LineWidth = 1;

    title('Densidad espectral de Potencia');
    legend('No polarizado', 'Polarizado','Anal�tico');
    figure();
    hold on
   
% Por periodogramas
Rxx_Vector = zeros(16,128);
% Se divide la entrada en 16 grupos de 256 muestras, calculando
% a 16 funciones de autocorrelaci�n sus 128 primeros valores
% para el caso no polarizado
for l = 1:16
    for k = 0:127
        sum = 0;
        for i = 0:256-k-1
            sum = sum + (x(256*(l-1)+i+1) * x(256*(l-1)+i+1+k));
        end
        Rxx_Vector(l,k+1) = (1/(256-k)) * sum;
    end
end
Sxx_Vector = zeros(128,16);
% Se calcula la densidad espectral de cada uno
for k = 1:16
    Sxx_Vector(:,k) = fft(Rxx_Vector(k,:));
end
Sxx_Vector = Sxx_Vector';
Sxx_Med = zeros(1,128);
% Se estima la densidad promedio
for k = 1:16
    Sxx_Med = Sxx_Med + Sxx_Vector(k,:);
end
Sxx_Med = Sxx_Med/16;
mag_SxxMed = abs(Sxx_Med);
SxxNP(mag_SxxMed<1e-6) = 0;
figure
 p3 = plot(1:128,mag_SxxMed); 
     figure();
    
    
end