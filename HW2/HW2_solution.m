clear all
%%
%Training
%Read the TrainingSamplesDCT_8.mat file
load('dataset/TrainingSamplesDCT_8.mat');
%Save TrainsampleDCT_BG and TrainsampleDCT_FG in temporary value
train_BG = TrainsampleDCT_BG;
train_FG = TrainsampleDCT_FG;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem (a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_BG = size(train_BG,1) / (size(train_BG,1) + size(train_FG,1));
P_FG = size(train_FG,1) / (size(train_BG,1) + size(train_FG,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem (b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate the mean and variance of every features when cheetah
%mean_ch is the mean and var_ch is the variance
mean_ch = mean(train_FG,1);
std_ch = std(train_FG,0,1);

%Calculate the mean and variance of every features when grass
%mean_gr is the mean and var_gr is the variance
mean_gr = mean(train_BG,1);
std_gr = std(train_BG,0,1);

%Plot the 64-plots
for j=1:1:4
    position = 1; %Define the subplot row index
    for i=(j-1)*16+1:1:(j-1)*16+16
        figure(j);
        subplot(4,4,position);
        x=-(mean_ch(i)+4*std_ch(i)):0.0005:(mean_ch(i)+4*std_ch(i));
        y=normpdf(x,mean_ch(i),std_ch(i));
        %Plot the cheetah line
        plot(x,y);
        hold on
        x=-(mean_gr(i)+4*std_gr(i)):0.0005:(mean_gr(i)+4*std_gr(i));
        y=normpdf(x,mean_gr(i),std_gr(i));
        %Plot the grass line and mark it as red
        plot(x,y,'r');
        position = position + 1;
        title({['k=',num2str(i)]},'Fontsize',12,'interpreter','latex');
    end
    set(gcf,'Position',[400,100,900,600]);
    %Save the images
    saveas(gcf, ['Images/subplot',num2str(j),'.jpg']);
    close(gcf);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem (c)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The 64-dimensional Gaussians
%Calculate the covariance matrix of cheetah
cov_ch = cov(train_FG);
%Calculate the covariance matrix of grass
cov_gr = cov(train_BG);

%Read original image
I = imread('dataset/cheetah.bmp');
I = im2double(I);
%Define the loop numbers
loop_row = size(I,1) - 8 + 1;
loop_column = size(I,2) - 8 + 1;
%Caculate the threshold
T = P_BG / P_FG;

mask = zeros(size(I));
%Read the Zig-Zag file
position_ref = load('dataset/Zig-Zag Pattern.txt');
%Define the array for saving DCT coeffiences according to Zig-Zag
DCT_coeffience = zeros([1,64]);

for i=1:1:loop_row
    for j=1:1:loop_column
        block = I(i:i+7,j:j+7);
        DCT_block = dct2(block);
        %Map DCT_block matrix to array according Zig-Zag
        for row=1:1:8
            for column=1:1:8
                DCT_coeffience(1,position_ref(row,column)+1)=DCT_block(row,column);
            end
        end
        P_x_FG = mvnpdf(DCT_coeffience,mean_ch,cov_ch);
        P_x_BG = mvnpdf(DCT_coeffience,mean_gr,cov_gr);
        if P_x_FG/P_x_BG > T
            mask(i,j) = 1;
        end
    end
end
imshow(mask);
