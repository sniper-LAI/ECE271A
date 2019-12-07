function [error] = fun_BDR(T, weight_BG, weight_FG, mu_BG, mu_FG, sigma_BG, sigma_FG)
% This function is for BDR
% weight -- the matrix of weight, size of (C,1)
% mu -- the matrix of mean, size of (C, 64)
% sigma -- tensor of sigma, size of (C, 64)

%Load DCT file
load('DCT_coeffience.mat');
dimension = [1,2,4,8,16,24,32,40,48,56,64];
C = length(weight_BG);
error = [];
for d=dimension
    DCT_coeffience_d = DCT_coeffience(:, 1:d);
    % Select the corresponding parameters
    mu_FG_d = mu_FG(:, 1:d); 
    mu_BG_d = mu_BG(:, 1:d);
    sigma_FG_d = reshape(repmat(eye(d), [1, C])*diag(reshape(sigma_FG(:, 1:d)', [C*d, 1])), [d, d, C]);
    sigma_BG_d = reshape(repmat(eye(d), [1, C])*diag(reshape(sigma_BG(:, 1:d)', [C*d, 1])), [d, d, C]);
    % Compute a predict mask
    MixG_FG = gmdistribution(mu_FG_d,sigma_FG_d,weight_FG);
    MixG_BG = gmdistribution(mu_BG_d,sigma_BG_d,weight_BG);
    I_pre = pdf(MixG_FG, DCT_coeffience_d) > T * pdf(MixG_BG, DCT_coeffience_d);
    % Compute PoE
    error_temp = fun_error(I_pre);
    error = [error,error_temp];
end

end