function [mask_64] = fun_bayesBDR(train_BG,train_FG,Alpha,i)
%This function is for Bayes BDR.
%Use Bayes Estimation and BDR, return the predict mask of original image.
%i - represent the strategy we use

%Load data
load('dataset/Prior_',num2str(i),'.mat');
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

%Compute Bayes Estimation and parameters of the predictive distribution
%Use mu_p and mu_cov as the mean and convariance matrix of the predictive
%distribution.
%BG predictive distribution 
mu_p_BG = 
%FG predictive distribution 
mu_p_FG = 

end