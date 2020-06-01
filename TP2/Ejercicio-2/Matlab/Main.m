function Main(x,kmax)

    %PUNTO 1
    
    %Creamos Rxxs (estimaciones)
    Rxxnp = Rnp(x,kmax);
    Rxxp = Rp(x,kmax);
    
    %Creamos rxxs (estimaciones)
    rxxnp = Rxxnp./Rxxnp(1);
    rxxp = Rxxp./Rxxp(1);
    
    aux_rxx = 1:1:128;
    aux_phi = 1:1:127;
    
    %Ploteamos rxxs (estimaciones)
    hold on
    p1 = plot(aux_rxx, rxxnp, aux_rxx, rxxp);
    p1(1).LineWidth = 1.75;
    p1(2).LineWidth = 1.75;
    legend('No polarizado', 'Polarizado');
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
    figure();
    
    
    %PUNTO 3
    
    
    
    %PUNTO 4
    
    %PERIODRIGRAMAS (PUNTO 5)
    
    %Periodigrama y plot
    FftPeriod = (abs(fft(x)).^2)./max(size(x));
    hold on
    p3 = plot(FftPeriod);
    %legend('No polarizado', 'Polarizado');
    p3(1).LineWidth = 1;
    figure();
    
    %FFT de Rxxs (estimados)
    FftRxxnp=abs(fft([Rxxnp,fliplr(Rxxnp)]));
    FftRxxp=abs(fft([Rxxp,fliplr(Rxxp)]));
    
    hold on
    p4 = plot( [1:length(FftRxxnp)].*length(FftPeriod)./length(FftRxxnp), FftRxxnp);
    p4(1).LineWidth = 1;
    p5 = plot( [1:length(FftRxxp)].*length(FftPeriod)./length(FftRxxp), FftRxxp);
    p5(1).LineWidth = 1;
    legend('No polarizado', 'Polarizado');
    
    
    
    %Caculamos Rxx y rxx
    
    %Graficamos Rxx y rxx
    
    
    
        
end