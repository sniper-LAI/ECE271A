function [] = fun_EM(C, data_BG, data_FG)
% This function is for EM
% C -- number of mixtures we want to use
% data_BG -- training data of BG
% data_FG -- training data of FG
%
% The following is abstract process:
% 1. Initialize parameters of mixture gaussian and weight
% 2. Compute initial h matrix
% 3. Loop of EM
% 
% Return:
% 

% For BG EM
loop = 100;
disp(['Start BG EM with C=',num2str(C)]);
N = size(data_BG,1); % number of samples
h_BG = zeros(N,C);
[weight_BG, mu_BG, sigma_BG] = fun_getinit(C);
% weight -- the matrix of weight, size of (C,1)
% mu -- the matrix of mean, size of (C, 64)
% sigma -- tensor of sigma, size of (64, 64, C)
% h_BG -- size of (N,C)

for step=1:1:loop
    % Compute h_BG matrix
    for i=1:1:N
        for j=1:1:C
            h_BG(i,j)=weight_BG(j,1)*fun_mvgaussian(data_BG(i,:),mu_BG(j,:),sigma_BG(:,:,j));
        end
    end
    h_BG = h_BG ./ sum(h_BG,2);
    % Update parameter
    weight_BG = sum(h_BG,2) / N;
    
end

end