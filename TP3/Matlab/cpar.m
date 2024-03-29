function [phikk,phi,phis_triang] = cpar(rxx,kmax,flag_print)

    phikk = rxx(2);
    phis_triang=zeros(kmax-1);
    phi = rxx(2);
    phis_triang(1,1)=rxx(2);
    for i = 2:kmax-1

        R = toeplitz([rxx(1:i)]);
        phi = linsolve(R,rxx(2:i+1).'); %%Resuelvo el sistema de ecuaciones para obtener los phikk
        phikk = [phikk, phi(end)];
        phis_triang(i,:) = [phi' zeros(1,kmax-1-i)];
        if(flag_print)
        fprintf('Yule walker matrices %i\r\n',i)
        phi
        R
        end
    end
end