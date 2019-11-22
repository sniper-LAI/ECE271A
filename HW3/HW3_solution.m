clear all
%Training
%Read the TrainingSamplesDCT_8.mat file
load('dataset/TrainingSamplesDCT_subsets_8.mat');
load('dataset/Alpha.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Strategy 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Use strategy 1 and train set D1
%Save D1_BG and D1_FG in temporary value
train_BG = D1_BG;
train_FG = D1_FG;
fun_general(1,train_BG,train_FG,alpha,1);
%Use strategy 1 and train set D2
%Save D1_BG and D1_FG in temporary value
train_BG = D2_BG;
train_FG = D2_FG;
fun_general(2,train_BG,train_FG,alpha,1);
%Use strategy 1 and train set D3
%Save D1_BG and D1_FG in temporary value
train_BG = D3_BG;
train_FG = D3_FG;
fun_general(3,train_BG,train_FG,alpha,1);
%Use strategy 1 and train set D4
%Save D1_BG and D1_FG in temporary value
train_BG = D4_BG;
train_FG = D4_FG;
fun_general(4,train_BG,train_FG,alpha,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Strategy 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Use strategy 2 and train set D1
%Save D1_BG and D1_FG in temporary value
train_BG = D1_BG;
train_FG = D1_FG;
fun_general(1,train_BG,train_FG,alpha,2);
%Use strategy 1 and train set D2
%Save D1_BG and D1_FG in temporary value
train_BG = D2_BG;
train_FG = D2_FG;
fun_general(2,train_BG,train_FG,alpha,2);
%Use strategy 1 and train set D3
%Save D1_BG and D1_FG in temporary value
train_BG = D3_BG;
train_FG = D3_FG;
fun_general(3,train_BG,train_FG,alpha,2);
%Use strategy 1 and train set D4
%Save D1_BG and D1_FG in temporary value
train_BG = D4_BG;
train_FG = D4_FG;
fun_general(4,train_BG,train_FG,alpha,2);