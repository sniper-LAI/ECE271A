clear all
%%
%Training
%Read the TrainingSamplesDCT_8.mat file
load('dataset/TrainingSamplesDCT_8.mat');
%Save TrainsampleDCT_BG and TrainsampleDCT_FG in temporary value
train_BG = TrainsampleDCT_BG;
train_FG = TrainsampleDCT_FG;

%Find the second largest value in each row of matrix train_BG
[M_BG,N_BG] = max(train_BG,[],2);
train_BG(bsxfun(@eq, train_BG, M_BG)) = -Inf; % Set the largest value in each row to -inf
[M_BG,N_BG] = max(train_BG,[],2);

%Find the second largest value in each row of matrix train_FG
[M_FG,N_FG] = max(train_FG,[],2);
train_FG(bsxfun(@eq, train_FG, M_FG)) = -Inf; % Set the largest value in each row to -inF
[M_FG,N_FG] = max(train_FG,[],2);

%Plot the histogram
subplot(2,1,1);
h1 = histogram(N_BG);
ylim([0, 500]); 
ylabel('Frequency', 'interpreter', 'latex','FontSize', 10);
xlabel('Index', 'interpreter', 'latex'); 
title({['Index histograms of $$P_{X|Y}(x|cheetah)$$']},'Fontsize',12,'interpreter','latex');
subplot(2,1,2);
h2 = histogram(N_FG);
ylim([0, 50]);
ylabel('Frequency', 'interpreter', 'latex','FontSize', 10);
xlabel('Index', 'interpreter', 'latex'); 
title({['Index histograms of $$P_{X|Y}(x|grass)$$']},'Fontsize',12,'interpreter','latex');
%Save the statistic data
F_x_BG = zeros(1,64)
F_x_BG(min(N_BG):max(N_BG)) = h1.Values;
F_x_FG = zeros(1,64)
F_x_FG(min(N_FG):max(N_FG)) = h2.Values;
%Save the histogram figure
set(gcf,'Position',[400,100,900,600]);
saveas(gcf, ['Images/histograms.jpg']);
close(gcf);

%Calculate the estimation of class-conditionals for two classes and priors probabilities
P_x_BG = F_x_BG ./ sum(F_x_BG);
P_x_FG = F_x_FG ./ sum(F_x_FG);
P_BG = size(train_BG,1) / (size(train_BG,1) + size(train_FG,1));
P_FG = size(train_FG,1) / (size(train_BG,1) + size(train_FG,1));
%%
%Read original image
I = imread('dataset/cheetah.bmp');
I = im2double(I);
