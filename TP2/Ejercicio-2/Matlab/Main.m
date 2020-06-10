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
    
    
    %PUNTO 3
    %Debemos modelar X(n) a través de un Moving Average de orden 2.
%    thetas = thetacalculator(rxx);
    %aca hay que obtener el c�lculo analitico de la Rxx y rxx a partir de
    %lo que calculo frankie.
    %Graficamos Rxx y rxx
    sizeOfX = size(x);
    [thetas, min] = thetaestimator(x,1);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%
   %MAGIA
    syms th21x th22x
    S= solve(rxxnp(2)*(th21x^2+th22x^2+1) == th21x*th22x+th21x, rxxnp(3)*(th21x^2+th22x^2+1) == th22x);
    theta21v=real(vpa(S.th21x))
    theta22v= real(vpa(S.th22x))
    theta21= theta21v(2)
    theta22=theta22v(2)
%    theta21 = -1.239619050; %Pongo cada theta en una variable con su subindice en el nombre
  %  theta22 =.2531328821;
    varN = min/(sizeOfX(2) - 2); %Calculo la varianza de e(n) por fórmula (pág 603)
    rxxCalc=  zeros(1, 128);
    rxxCalc(1)=(theta21*theta21+theta22*theta22+1)/(1+theta21^2+theta22^2);
    rxxCalc(2)= (theta21+theta21*theta22)/(1+theta21^2+theta22^2);
    rxxCalc(3)= theta22/(1+theta21^2+theta22^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %PUNTO 4
    
    %PERIODRIGRAMAS (PUNTO 5)
    
    %Periodigrama y plot
    FftPeriod = (abs(fft(x)).^2)./max(size(x));
    hold on
    p3 = plot(FftPeriod);
    p3(1).LineWidth = 1;
    title('Periodigrama calculado');
    figure();
    
    %FFT de Rxxs (estimados)
    FftRxxnp=abs(fft([Rxxnp,fliplr(Rxxnp)]));
    FftRxxp=abs(fft([Rxxp,fliplr(Rxxp)]));
    fftTeo=fft([rxxCalc,fliplr(rxxCalc)]);
    fftTeo=abs(fftTeo);
    
    hold on
    p4 = plot( [1:length(FftRxxnp)].*length(FftPeriod)./length(FftRxxnp), FftRxxnp);
    p4(1).LineWidth = 1;
    p5 = plot( [1:length(FftRxxp)].*length(FftPeriod)./length(FftRxxp), FftRxxp);
    p5(1).LineWidth = 1;
    p6 = plot( [1:length(fftTeo)].*length(FftPeriod)./length(fftTeo), fftTeo);
    p6(1).LineWidth = 1;
    title('FFT estimado');
    legend('No polarizado', 'Polarizado');

end