function [] = fun_zigzag()
%This function is for computing the DCT coe?cients of original image. 
%Decomposition into 8 x 8 image blocks, compute the DCT of each block, and
%zig-zag scan.

%Read original image
I = imread('dataset/cheetah.bmp');
I = im2double(I);
%Define the loop numbers
loop_row = size(I,1) - 8 + 1;
loop_column = size(I,2) - 8 + 1;
%Read the Zig-Zag file
position_ref = load('dataset/Zig-Zag Pattern.txt');
%Define the array for saving DCT coeffiences according to Zig-Zag
DCT_coeffience = zeros([loop_row*loop_column,64]);
k=1;

for i=1:1:loop_row
    for j=1:1:loop_column
        block = I(i:i+7,j:j+7);
        DCT_block = dct2(block);
        %Map DCT_block matrix to array according Zig-Zag
        for row=1:1:8
            for column=1:1:8
                DCT_coeffience(k,position_ref(row,column)+1)=DCT_block(row,column);
            end
        end
        k=k+1;
    end
end
save('../DCT_coeffience.mat','DCT_coeffience');
end