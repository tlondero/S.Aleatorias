function corrBiva( x, y, sigma1, sigma2, corr, muestras )
%BIVANOCORR 2 vectores de muestras con valores dist normal no correlacionados
%   Uso las funciones rayleigh_dist y theta_dist para encontrar valores
%   para radio y angulo de las muestras. Dev

Z = [sigma1*sigma1 corr*sigma1*sigma2; corr*sigma1*sigma2 sigma2*sigma2];
[Zv, Zval] = eig(Z);

Zvt = Zv.';

mat = [x;y];

resultMat = [];
for i = 1 : muestras
    resultMat(:,i) = Zvt*mat(:,i); 
end

plot(resultMat(1,:), resultMat(2,:),'.');

end

