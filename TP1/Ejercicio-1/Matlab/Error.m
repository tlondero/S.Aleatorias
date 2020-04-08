N= 1843;
mu = 0.5;
sigma = 0.5./sqrt(N);
mx = makedist('Normal','mu',mu,'sigma',sigma);
P = 2. * cdf(mx,0.94.*mu)%La probabilidad