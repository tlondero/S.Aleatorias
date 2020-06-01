function [phikk] = cpar(rxx,kmax)
    phikk = rxx(2);
    for i = 2:kmax-1
        R = toeplitz([rxx(1:i)]);
        phi = linsolve(R,rxx(2:i+1).');
        phikk = [phikk, phi(end)];
    end
end