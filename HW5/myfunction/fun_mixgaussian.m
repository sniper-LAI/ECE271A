function [p] = fun_mixgaussian(data,weight,mu,sigma)
% This function is for mix Gaussian
% weight -- the matrix of weight, size of (1,C)
% mu -- the matrix of mean, size of (C, d)
% sigma -- tensor of sigma, size of (d, d, C)

C = size(weight,2);
p = 0;
for idx=1:1:C
    p = p + weight(idx)*mvnpdf(data,mu(idx,:),sigma(:,:,idx));
end

end