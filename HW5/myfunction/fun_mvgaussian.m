function [y] = fun_mvgaussian(x,mean,cov)
%This function is for MV Gaussian

d = size(x,2);
y = 1/sqrt((2*pi)^d*det(cov))*exp(-(x-mean)*cov^-1*(x-mean)'/2);

end