function [error] = fun_bayesBDR(train_BG,train_FG)
%This function is for ML BDR.

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

%Calculate the covariance matrix of cheetah
cov_ch = fun_cov(train_FG,mean_ch);
%Calculate the covariance matrix of grass
cov_gr = fun_cov(train_BG,mean_gr);

%Load DCT file
load('DCT_coeffience.mat');
%Caculate the threshold
T = P_BG / P_FG;
%Define the loop numbers
loop_row = size(I,1) - 8 + 1;
loop_column = size(I,2) - 8 + 1;
k=1;

for z=1:1:loop_row
    for j=1:1:loop_column
        P_x_FG = fun_mvgaussian(DCT_coeffience(k,:),mean_ch,cov_ch);
        P_x_BG = fun_mvgaussian(DCT_coeffience(k,:),mean_gr,cov_gr);
        if P_x_FG/P_x_BG > T
            mask_64(z,j) = 1;
        end
        k=k+1;
    end
end
%Calculate the probability of error
error = length(find((mask_64-I)~=0)) / (size(I,1) * size(I,2));

end