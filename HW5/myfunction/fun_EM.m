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

loop = 200;
% For BG EM
disp(['Start BG EM with C=',num2str(C),',M=',num2str(M)]);
N = size(data_BG,1); % number of samples
h_BG = zeros(N,C);
[weight_BG, mu_BG, sigma_BG] = fun_getinit(C);
% weight -- the matrix of weight, size of (1, C)
% mu -- the matrix of mean, size of (C, 64)
% sigma -- tensor of sigma, size of (64, 64, C)
% h_BG -- size of (N,C)
% data_BG -- size of (N,64)
weight_BG_pre = weight_BG;
mu_BG_pre = mu_BG;
sigma_BG_pre = sigma_BG;

for step=1:1:loop
    % Compute h_BG matrix
    for i=1:1:N
        for j=1:1:C
            h_BG(i,j)=weight_BG_pre(j)*mvnpdf(data_BG(i,:),mu_BG_pre(j,:),sigma_BG_pre(:,:,j));
        end
        h_BG(i, :) = h_BG(i, :) / sum(h_BG(i, :));
    end
%     h_BG = h_BG ./ sum(h_BG,2);
    % Update parameter
%     weight_BG = sum(h_BG) / N;  % Update weight
%     mu_BG = h_BG' * data_BG ./ sum(h_BG)';  % Update mu
    for j = 1:C
        sumh = sum(h_BG(:, j));
        mu_BG(j, :) = h_BG(:, j)'*data_BG(:, :)./sumh;
        weight_BG(j) = sumh / N;
    end
    for j=1:C
       sum_1=0;
       sum_2=0;
       for i=1: N
           sum_1=sum_1+h_BG(i,j)*(data_BG(i,:)-mu_BG(j,:)).^2;
           sum_2=sum_2+h_BG(i,j);
       end
       var = sum_1 / sum_2;
       var(var < 0.002) = 0.002;
       sigma_BG(:,:,j) = diag(var);
   end
%     for j=1:1:C % Update sigma
%         seed = h_BG(:,j)' * (data_BG - mu_BG(j,:)).^2 ./ sum(h_BG(:,j));
%         seed(seed < 0.001) = 0.001;
%         sigma_BG(:,:,j) = diag(seed);
%     end
    if max(max(abs(mu_BG - mu_BG_pre)./abs(mu_BG_pre))) < 0.001
        break;
    end
    weight_BG_pre = weight_BG;
    mu_BG_pre = mu_BG;
    sigma_BG_pre = sigma_BG;
end


% For FG EM
disp(['Start FG EM with C=',num2str(C)]);
N = size(data_FG,1); % number of samples
h_FG = zeros(N,C);
[weight_FG, mu_FG, sigma_FG] = fun_getinit(C);
% weight -- the matrix of weight, size of (1,C)
% mu -- the matrix of mean, size of (C, 64)
% sigma -- tensor of sigma, size of (64, 64, C)
% h_BG -- size of (N,C)
% data_BG -- size of (N,64)
weight_FG_pre = weight_FG;
mu_FG_pre = mu_FG;
sigma_FG_pre = sigma_FG;

for step=1:1:loop
    % Compute h_BG matrix
    for i=1:1:N
        for j=1:1:C
            h_FG(i,j)=weight_FG_pre(j)*mvnpdf(data_FG(i,:),mu_FG_pre(j,:),sigma_FG_pre(:,:,j));
        end
        h_FG(i, :) = h_FG(i, :) / sum(h_FG(i, :));
    end
    % Update parameter
%     weight_FG = sum(h_FG) / N;  % Update weight
%     mu_FG = h_FG' * data_FG ./ sum(h_FG)';  % Update mu
%     for j=1:1:C % Update sigma
%         seed = h_FG(:,j)' * (data_FG - mu_FG(j,:)).^2 ./ sum(h_FG(:,j));
%         seed(seed < 0.001) = 0.001;
%         sigma_FG(:,:,j) = diag(seed);
%     end
    for j = 1:C
        sumh = sum(h_FG(:, j));
        mu_FG(j, :) = h_FG(:, j)'*data_FG(:, :)./sumh;
        weight_FG(j) = sumh / N;
    end
    for j=1:C
       sum_1=0;
       sum_2=0;
       for i=1: N
           sum_1=sum_1+h_FG(i,j)*(data_FG(i,:)-mu_FG(j,:)).^2;
           sum_2=sum_2+h_FG(i,j);
       end
       var = sum_1 / sum_2;
       var(var < 0.002) = 0.002;
       sigma_FG(:,:,j) = diag(var);
   end
    if max(max(abs(mu_FG - mu_FG_pre)./abs(mu_FG_pre))) < 0.001
        break;
    end
    weight_FG_pre = weight_FG;
    mu_FG_pre = mu_FG;
    sigma_FG_pre = sigma_FG;
end

save(['savedata/MuSigma_C=',num2str(C),'M=',num2str(M),'.mat'],'mu_BG',...
    'mu_FG','sigma_BG','sigma_FG','weight_BG','weight_FG')
end