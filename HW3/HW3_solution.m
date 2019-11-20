clear all
%Training
%Read the TrainingSamplesDCT_8.mat file
load('dataset/TrainingSamplesDCT_subsets_8.mat');
load('dataset/Alpha.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem (a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Use strategy 1 and train set D1
%Save D1_BG and D1_FG in temporary value
train_BG = D1_BG;
train_FG = D1_FG;
Alpha = alpha(1);
mask_64 = fun_bayesBDR(train_BG,train_FG,Alpha,i);
