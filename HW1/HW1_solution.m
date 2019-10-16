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
train_BG(bsxfun(@eq, train_BG, M_BG)) = -1; % Set the largest value in each row to -inf
[M_BG,N_BG] = max(train_BG,[],2);

%Find the second largest value in each row of matrix train_FG
[M_FG,N_FG] = max(train_FG,[],2);
train_FG(bsxfun(@eq, train_FG, M_FG)) = -1; % Set the largest value in each row to -inF
[M_FG,N_FG] = max(train_FG,[],2);

%Plot the frequency histogram
subplot(2,1,1);
h1 = histogram(N_BG);
ylim([0, 500]); 
ylabel('Frequency', 'interpreter', 'latex','FontSize', 10);
xlabel('Index', 'interpreter', 'latex'); 
title({['Frequency histograms of background data']},'Fontsize',12,'interpreter','latex');
subplot(2,1,2);
h2 = histogram(N_FG);
ylim([0, 50]);
ylabel('Frequency', 'interpreter', 'latex','FontSize', 10);
xlabel('Index', 'interpreter', 'latex'); 
title({['Frequency histograms of foreground data']},'Fontsize',12,'interpreter','latex');
%Save the statistic data
F_x_BG = zeros(1,64);
F_x_BG(min(N_BG):max(N_BG)) = h1.Values;
F_x_FG = zeros(1,64);
F_x_FG(min(N_FG):max(N_FG)) = h2.Values;
%Save the histogram figure
set(gcf,'Position',[400,100,900,600]);
saveas(gcf, ['Images/histograms1.jpg']);
close(gcf);

%Calculate the estimation of class-conditionals for two classes and priors probabilities
P_x_BG = F_x_BG ./ sum(F_x_BG);
P_x_FG = F_x_FG ./ sum(F_x_FG);
P_BG = size(train_BG,1) / (size(train_BG,1) + size(train_FG,1));
P_FG = size(train_FG,1) / (size(train_BG,1) + size(train_FG,1));

% %Plot the index histogram
subplot(2,1,1);
h1 = histogram(N_BG,'Normalization','pdf');
ylim([0, 0.4]); 
ylabel('Probability', 'interpreter', 'latex','FontSize', 10);
xlabel('Index', 'interpreter', 'latex'); 
title({['Index histograms of $$P_{X|Y}(x|grass)$$']},'Fontsize',12,'interpreter','latex');
subplot(2,1,2);
h2 = histogram(N_FG,'Normalization','pdf');
ylim([0, 0.2]);
ylabel('Probability', 'interpreter', 'latex','FontSize', 10);
xlabel('Index', 'interpreter', 'latex'); 
title({['Index histograms of $$P_{X|Y}(x|cheetah)$$']},'Fontsize',12,'interpreter','latex');
%Save the histogram figure
set(gcf,'Position',[400,100,900,600]);
saveas(gcf, ['Images/histograms2.jpg']);
close(gcf);

%Read original image
I = imread('dataset/cheetah.bmp');
I = im2double(I);
%Define the loop numbers
loop_row = size(I,1) - 8 + 1;
loop_column = size(I,2) - 8 + 1;

mask = zeros(size(I));
position_ref = load('dataset/Zig-Zag Pattern.txt');
T = P_BG / P_FG; % Caculate the threshold

for i=1:1:loop_row
    for j=1:1:loop_column
        block = I(i:i+7,j:j+7);
        DCT_block = dct2(block);
        DCT_block = abs(DCT_block);
        [x,y] = find(DCT_block==max(DCT_block(:))); % Find the largest coefficient
        DCT_block(x,y) = -1; % Set the largest value as -1
        [x,y] = find(DCT_block==max(DCT_block(:))); % Find the second largest coefficient and its position
        feature = position_ref(x,y) + 1;
        %Decide the binary mask
%         %Before decide the mask, we should caluate two class-conditionals
%         P_FG_Decision = P_x_FG(1,feature) * P_FG / (P_x_FG(1,feature)* P_FG + P_x_BG(1,feature) * P_BG);
%         P_BG_Decision = P_x_BG(1,feature) * P_BG / (P_x_FG(1,feature)* P_FG + P_x_BG(1,feature) * P_BG);
        if P_x_FG(1,feature)/P_x_BG(1,feature) > T
            mask(i,j) = 1;
        end
    end
end

subplot(1,2,1)
I = imread('dataset/cheetah_mask.bmp');
I = im2double(I);
imshow(I);
subplot(1,2,2)
imshow(mask);
%Calculate the probability of error
error = length(find((mask-I)~=0)) / (size(I,1) * size(I,2));
title({['Probability of error is ',num2str(error*100,'%.2f'),'\%']},'Fontsize',12,'interpreter','latex');
%set(gcf,'Position',[900,600]);
saveas(gcf, ['Images/segmentation.jpg']);
close(gcf);