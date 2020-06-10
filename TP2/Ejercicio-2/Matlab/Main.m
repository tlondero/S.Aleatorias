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
    %Debemos modelar X(n) a travÃ©s de un Moving Average de orden 2.
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
    legend('No polarizado', 'Polarizado','Analítico');
    title('r_{xx}');
    figure();
        %%GraficoRxx estimaciones y analitico
    hold on
    p7 = plot(aux_rxx, Rxxnp, aux_rxx, Rxxp,aux_rxx,RxxCalc);
    p7(1).LineWidth = 1.75;
    p7(2).LineWidth = 1.75;
    legend('No polarizado', 'Polarizado','Analítico');
    title('R_{xx}');
    figure();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%periodograma
aux = zeros(16,128);

for k = 1:16
    for j = 0:127
        prev = 0;
        for i = 0:256-j-1
            prev = prev + x(256*(k-1)+i+1+j) * x(256*(k-1)+i+1) ;%% Lo parto en bloques
        end
        aux(k,j+1) = (1/(256-j)) * prev;
    end
end
Sxx = zeros(128,16);
for j = 1:16
    Sxx(:,j) = fft(aux(j,:));%%Se calcula la fft de la particion
end
Sxx = Sxx';
uSxx = zeros(1,128);
for j = 1:16
    uSxx = uSxx + Sxx(j,:);%%Promedio
end
uSxx = uSxx/16;
 p3 = plot([1:128],abs(uSxx)); 
     figure();    

    %FFT de Rxxs (estimados)
    FftRxxnp=abs(fft([Rxxnp]));
    FftRxxp=abs(fft([Rxxp]));
    fftTeo=fft([RxxCalc]);
    fftTeo=abs(fftTeo);
    
    hold on
    p4 = plot( [1:length(FftRxxnp)], FftRxxnp);
    p4(1).LineWidth = 1;
    p5 = plot( [1:length(FftRxxp)], FftRxxp);
    p5(1).LineWidth = 1;
    p6 = plot( [1:length(fftTeo)], fftTeo);
    p6(1).LineWidth = 1;
    p3 = plot([1:128],abs(uSxx)); 
    p3(1).LineWidth = 1;
    title('Densidad espectral de Potencia');
    legend('No polarizado', 'Polarizado','Analítico','Promediacion de periodogramas');
    figure();
    hold on
    
end