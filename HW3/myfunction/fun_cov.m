function [cov] = fun_cov(data,data_mean)
%This function is the maximum likelihood estimation of covariance matrix

N = size(data,1);
cov = (data-data_mean)'*(data-data_mean)./N;

end