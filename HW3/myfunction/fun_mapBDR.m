function [error] = fun_mapBDR(train_BG,train_FG,Alpha,i)
%This function is for MAP BDR.
%Use Bayes Estimation and BDR, return the predict mask of original image.
%i - represent the strategy we use

%Load data
load(['dataset/Prior_',num2str(i),'.mat']);
%Read the mask file
I = imread('dataset/cheetah_mask.bmp');
I = im2double(I);
%Define the predict mask
mask_64 = zeros(size(I));

P_BG = size(train_BG,1) / (size(train_BG,1) + size(train_FG,1));
P_FG = size(train_FG,1) / (size(train_BG,1) + size(train_FG,1));
%Calculate the mean of every features when cheetah
%mean_ch is the mean
mean_ch = fun_mean(train_FG);
%Calculate the mean of every features when grass
%mean_gr is the mean
mean_gr = fun_mean(train_BG);
%Compute the covariance matrix of class-condition
cov_ch = fun_cov(train_FG,mean_ch);
cov_gr = fun_cov(train_BG,mean_gr);
%Compute the covariance matrix of Gaussian prior
v = Alpha * W0;
cov_prior = diag(v);

%Compute MAP Estimation and parameters of the predictive distribution
%Use mu_p and mu_cov as the mean and convariance matrix of the predictive
%distribution. The equation is from DHS.
%BG predictive distribution 
mu_p_BG = cov_prior * inv(cov_prior + cov_gr/size(train_BG,1)) * ...
    mean_gr' + cov_gr/size(train_BG,1) * inv(cov_prior + cov_gr/size(train_BG,1))...
    * mu0_BG';
cov_p_BG = cov_gr;
%FG predictive distribution 
mu_p_FG = cov_prior * inv(cov_prior + cov_ch/size(train_FG,1)) * ...
    mean_ch' + cov_ch/size(train_FG,1) * inv(cov_prior + cov_ch/size(train_FG,1))...
    * mu0_FG';
cov_p_FG = cov_ch;

%Load DCT file
load('DCT_coeffience.mat');
%Caculate the threshold
T = P_BG / P_FG;
%Define the loop numbers
loop_row = size(I,1) - 8 + 1;
loop_column = size(I,2) - 8 + 1;
k=1;

for i=1:1:loop_row
    for j=1:1:loop_column
        P_x_FG = fun_mvgaussian(DCT_coeffience(k,:),mu_p_FG',cov_p_FG);
        P_x_BG = fun_mvgaussian(DCT_coeffience(k,:),mu_p_BG',cov_p_BG);
        if P_x_FG/P_x_BG > T
            mask_64(i,j) = 1;
        end
        k=k+1;
    end
end
%Calculate the probability of error
error = length(find((mask_64-I)~=0)) / (size(I,1) * size(I,2));

end