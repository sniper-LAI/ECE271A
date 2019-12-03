function [error] = fun_BDR(T, weight_BG, weight_FG, mu_BG, mu_FG, sigma_BG, sigma_FG)
% This function is for BDR
% weight -- the matrix of weight, size of (C,1)
% mu -- the matrix of mean, size of (C, 64)
% sigma -- tensor of sigma, size of (C, 64)

%Read the mask file
I = imread('dataset/cheetah_mask.bmp');
I = im2double(I);
%Define the predict mask
mask_64 = zeros(size(I));
%Load DCT file
load('DCT_coeffience.mat');
%Define the loop numbers
loop_row = size(I,1) - 8 + 1;
loop_column = size(I,2) - 8 + 1;
dimension = [1,2,4,8,16,24,32,40,48,56,64];
error = [];
for d=dimension
    k=1;
    for i=1:1:loop_row
        for j=1:1:loop_column
            P_x_FG = fun_mixgaussian(DCT_coeffience(k,1:d),weight_FG,mu_FG(:,1:d),sigma_FG(:,1:d));
            P_x_BG = fun_mixgaussian(DCT_coeffience(k,1:d),weight_BG,mu_BG(:,1:d),sigma_BG(:,1:d));
            if P_x_FG/P_x_BG > T
                mask_64(i,j) = 1;
            end
            k=k+1;
        end
    end
    %Calculate the probability of error
    error_temp = length(find((mask_64-I)~=0)) / (size(I,1) * size(I,2));
    error = [error,error_temp];
end

end