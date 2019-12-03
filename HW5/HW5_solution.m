clear all
%Training
%Read the TrainingSamplesDCT_8.mat file
load('dataset/TrainingSamplesDCT_8_new.mat');
%Save TrainsampleDCT_BG and TrainsampleDCT_FG in temporary value
train_BG = TrainsampleDCT_BG;
train_FG = TrainsampleDCT_FG;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute parameter from EM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C = 8;
for M=1:5
    fun_EM(C, train_BG, train_FG, M);
end
for C=[1,2,4,8,16,32]
    fun_EM(C, train_BG, train_FG, 0);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BDR with different mixture pair and
% dimension
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
%Read the TrainingSamplesDCT_8.mat file
load('dataset/TrainingSamplesDCT_8_new.mat');
%Save TrainsampleDCT_BG and TrainsampleDCT_FG in temporary value
train_BG = TrainsampleDCT_BG;
train_FG = TrainsampleDCT_FG;
%Compute threshold
P_BG = size(train_BG,1) / (size(train_BG,1) + size(train_FG,1));
P_FG = size(train_FG,1) / (size(train_BG,1) + size(train_FG,1));
T = P_BG / P_FG;
% for FG=1:5
%     load(['savedata/MuSigma_C=8M=',num2str(FG),'.mat'],'mu_FG', 'sigma_FG', 'weight_FG');
%     for BG=1:5
%         disp(['Start with FG=',num2str(FG),',BG=',num2str(BG)]);
%         load(['savedata/MuSigma_C=8M=',num2str(BG),'.mat'],'mu_BG', 'sigma_BG', 'weight_BG');
%         error = fun_BDR(T, weight_BG, weight_FG, mu_BG, mu_FG, sigma_BG, sigma_FG);
%         save(['savedata/error_FG=',num2str(FG),'&BG=',num2str(BG),'.mat'],'error');
%     end
% end
% for C=[1,2,4,8,16,32]
%     disp(['Start with C=',num2str(C)]);
%     load(['savedata/MuSigma_C=',num2str(C),'M=',num2str(0),'.mat'],'mu_BG',...
%         'mu_FG','sigma_BG','sigma_FG','weight_BG','weight_FG');
%     error = fun_BDR(T, weight_BG, weight_FG, mu_BG, mu_FG, sigma_BG, sigma_FG);
%     save(['savedata/error_C=',num2str(C),'&M=',num2str(0),'.mat'],'error');
% end

for FG=1:1:1
    load(['savedata/MuSigma_C=8M=',num2str(FG),'.mat'],'mu_FG', 'sigma_FG', 'weight_FG');
    for BG=1:1:1
        disp(['Start with FG=',num2str(FG),',BG=',num2str(BG)]);
        load(['savedata/MuSigma_C=8M=',num2str(BG),'.mat'],'mu_BG', 'sigma_BG', 'weight_BG');
        error = fun_BDR(T, weight_BG, weight_FG, mu_BG, mu_FG, sigma_BG, sigma_FG);
        save(['savedata/error_FG=',num2str(FG),'&BG=',num2str(BG),'.mat'],'error');
    end
end

