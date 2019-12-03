function [] = fun_EM(C, data_BG, data_FG, M)
% This function is for EM
% C -- number of mixtures we want to use
% M -- number of mixture pair, used as a lable
% data_BG -- training data of BG
% data_FG -- training data of FG
%
% The following is abstract process:
% 1. Initialize parameters of mixture gaussian and weight
% 2. Compute initial h matrix
% 3. Loop of EM

loop = 300;
% For BG EM
disp(['Start BG EM with C=',num2str(C),',M=',num2str(M)]);
N = size(data_BG,1); % number of samples
D = 64; % number of dimension
h_BG = zeros(N,C);
[weight_BG, mu_BG, sigma_BG] = fun_getinit(C,data_FG);
% weight -- the matrix of weight, size of (C, 1)
% mu -- the matrix of mean, size of (C, 64)
% sigma -- tensor of sigma, size of (C, 64)
% h_BG -- size of (N, C)
% data_BG -- size of (N, 64)
weight_BG_pre = weight_BG;
mu_BG_pre = mu_BG;
sigma_BG_pre = sigma_BG;

for step=1:1:loop
    % Compute h_BG matrix
    for j=1:C
        h_BG(:,j) = weight_BG_pre(j)*mvnpdf(data_BG, mu_BG_pre(j,:), diag(sigma_BG_pre(j,:)));
    end
    h_BG = h_BG ./ sum(h_BG, 2);
    % Update parameter
    % Update weight
    weight_BG = mean(h_BG, 1)';
    % Update Sigma
    sigma_temp = sum(reshape(h_BG, [1,N,C]).*(data_BG'-reshape(mu_BG_pre', [D,1,C])).^2, 2);
    sigma_BG = squeeze(sigma_temp)' ./ sum(h_BG, 1)';
    sigma_BG(sigma_BG < 0.002) = 0.002;
    % Update mu
    mu_BG = h_BG'*data_BG ./ sum(h_BG, 1)';
%     if max(max(abs(mu_BG - mu_BG_pre)./abs(mu_BG_pre))) < 0.001
%         break;
%     end
    weight_BG_pre = weight_BG;
    mu_BG_pre = mu_BG;
    sigma_BG_pre = sigma_BG;
end


% For FG EM
disp(['Start FG EM with C=',num2str(C)]);
N = size(data_FG,1); % number of samples
h_FG = zeros(N,C);
[weight_FG, mu_FG, sigma_FG] = fun_getinit(C,data_FG);
% weight -- the matrix of weight, size of (1,C)
% mu -- the matrix of mean, size of (C, 64)
% sigma -- tensor of sigma, size of (64, 64, C)
% h_BG -- size of (N,C)
% data_BG -- size of (N,64)
weight_FG_pre = weight_FG;
mu_FG_pre = mu_FG;
sigma_FG_pre = sigma_FG;

for step=1:1:loop
    % Compute h_FG matrix
    for j=1:C
        h_FG(:,j) = weight_FG_pre(j)*mvnpdf(data_FG, mu_FG_pre(j,:), diag(sigma_FG_pre(j,:)));
    end
    h_FG = h_FG ./ sum(h_FG, 2);
    % Update parameter
    % Update weight
    weight_FG = mean(h_FG, 1)';
    % Update sigma
    sigma_temp = sum(reshape(h_FG, [1,N,C]).*(data_FG'-reshape(mu_FG_pre', [D,1,C])).^2, 2);
    sigma_FG = squeeze(sigma_temp)' ./ sum(h_FG, 1)';
    sigma_FG(sigma_FG < 0.002) = 0.002;
    % Update mu
    mu_FG = h_FG'*data_FG ./ sum(h_FG, 1)';
%     if max(max(abs(mu_FG - mu_FG_pre)./abs(mu_FG_pre))) < 0.001
%         break;
%     end
    weight_FG_pre = weight_FG;
    mu_FG_pre = mu_FG;
    sigma_FG_pre = sigma_FG;
end

save(['savedata/MuSigma_C=',num2str(C),'M=',num2str(M),'.mat'],'mu_BG',...
    'mu_FG','sigma_BG','sigma_FG','weight_BG','weight_FG')
end