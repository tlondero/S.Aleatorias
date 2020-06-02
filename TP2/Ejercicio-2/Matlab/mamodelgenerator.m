function [estx] = mamodelgenerator(x)

sizeOfX = size(x);

theta = thetaestimator(x);
wgn = randn([1,sizeOfX(2)]);

estx = zeros(1, sizeOfX(2));

estx(1) = wgn(1)
for n = 2:sizeOfX(2)
    estx(n) = wgn(n) + wgn(n-1)*theta;
end


end
