function [weight, mu, sigma] = fun_getinit(C)
% This function is parameter initialization
% C -- number of mixtures we want to use
%
% Return:
% weight -- the matrix of weight, size of (C,1)
% mu -- the matrix of mean, size of (C, 64)
% sigma -- tensor of sigma, size of (64, 64, C)

weight = zeros(C,1);
mu = zeros(C,64);
sigma = zeros(64,64,C);

% Initialize weight
seed = rand(C,1);
weight = seed / sum(seed);

% Initialize mu
mu = rand(C,64);

% Initialize sigma
for index=1:1:C
    seed = rand(64,1);
    sigma(:,:,index) = diag(seed);
end

end