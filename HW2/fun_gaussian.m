function [y] = fun_gaussian(x,mean,variance)
%This function is for Gaussian

y = exp(-(x-mean).^2/2/variance^2)./variance./sqrt(2*pi); 

end