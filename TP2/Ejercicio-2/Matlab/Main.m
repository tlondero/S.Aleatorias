function Main(x,kmax)
    %Creamos Rxxs
    Rxxnp = Rnp(x,kmax);
    Rxxp = Rp(x,kmax);
    
    %Creamos rxxs (normalizamos)
    rxxnp = Rxxnp./Rxxnp(1);
    rxxp = Rxxp./Rxxp(1);
    
    aux_rxx = 1:1:128;
    aux_phi = 1:1:127;
    
    %Ploteamos rxxs
    hold on
    p1 = plot(aux_rxx, rxxnp, aux_rxx, rxxp);
    p1(1).LineWidth = 1.75;
    p1(2).LineWidth = 1.75;
    legend('No polarizado', 'Polarizado');
    figure();
    %figure('$r_{xx}$ normalizado y no normalizado');
    
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
    
    
    %Periodigrama y plot
    FftPeriod = (abs(fft(x)).^2)./max(size(x));
    hold on
    p3 = plot(FftPeriod);
    %legend('No polarizado', 'Polarizado');
    p3(1).LineWidth = 1;
        
end