function [mean] = fun_mean(data) 
%This function is the maximum likelihood estimation of mean

N = size(data,1);
A = ones(1,N);
mean = A * data ./ N;

end

