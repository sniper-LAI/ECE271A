function [result] = fun_error(I_pre)
% This function is for computing error

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
k=1;
for i=1:1:loop_row
    for j=1:1:loop_column
        mask_64(i,j) = I_pre(k);
        k=k+1;
    end
end
%Calculate the probability of error
result = length(find((mask_64-I)~=0)) / (size(I,1) * size(I,2));
end