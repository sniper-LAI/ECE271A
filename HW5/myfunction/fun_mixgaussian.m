function [p] = fun_mixgaussian(data,weight,mu,sigma)
% This function is for mix Gaussian
% weight -- the matrix of weight, size of (C,1)
% mu -- the matrix of mean, size of (C, D)
% sigma -- tensor of sigma, size of (C, D)

C = size(weight,1);
p = 0;
for idx=1:C
    p = p + weight(idx)*mvnpdf(data,mu(idx,:),diag(sigma(idx,:)));
end

end