function [weight, mu, sigma] = fun_getinit(C,data)
% This function is parameter initialization
% C -- number of mixtures we want to use
%
% Return:
% weight -- the matrix of weight, size of (C,1)
% mu -- the matrix of mean, size of (C, 64)
% sigma -- tensor of sigma, size of (C, 64)

% Initialize weight
weight = rand(C,1);
weight = weight / sum(weight);
% Initialize mu
mu = 0.1 * rand(C,64) + mean(data);

% Initialize sigma
sigma = rand(C, 64);

end