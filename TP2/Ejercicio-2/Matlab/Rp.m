function [Rxx] = Rp(x,kmax)
    N=max(size(x));
    Rxx=0;  
    for i = 0:kmax-1
        Rxx=[Rxx,(sum(x(1:N-i) .* x(i+1:N))*(1/(N)))];
    end
    Rxx=Rxx(2:end);
end