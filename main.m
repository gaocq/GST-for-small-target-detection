%% Introdcution
% This source code  is for infrared small target detection method based on  Generalized Structure Tensor (GST).
% If you use this code in your publications, please cite: 
% @article{Gao2008Infrared,   
%  author={Chenqiang Gao and Jinwen Tian and Peng Wang},    
%  journal={Electronics Letters},   
%  title={Generalised-structure-tensor-based infrared small target detection},   
%  year={2008},   
%  volume={44},   
%  number={23},   
%  pages={1349-1351}}  
%% Contact
% If you have any questions, please contact:  
% Author: Chenqiang Gao  
% Email: gaochenqiang@gmail.com *or* gaocq@cqupt.edu.cn  
% Copyright: Chongqing University of Posts and Telecommunications  
%% License
% This code is only freely available for non-commercial research use. If you have other purpose, please contact me.


clc;
close all;
clear all;

% parameter setting
sigma1 = 0.6;
sigma2 = 1.1;
boundaryWidth = 5; % the boundary width
filterSize = 5;  % a 5 * 5 size 

% compute F filter
F1 = Ffilter(1, sigma1, filterSize);
h = Ffilter(-2, sigma2, filterSize);

strReadDir = './images/';
strSaveDir = './results/';
files = {'01.bmp', '02.bmp'};
for index = 1:length(files)
    I = imread([strReadDir files{index}]);
    [m n] = size(I);
    f1 = conv2(double(I), F1, 'same');
    Z = f1.^2/255;
    I20 = conv2(Z, h, 'same');
    I10 = conv2(abs(Z), abs(h), 'same');
    coscs = cos(atan2(imag(I20), real(I20)));
    % compute the certainty map
    Ct = abs(I20) .* I10 .* (1+coscs);
    revised_Ct = reviseImageBoundary(Ct, boundaryWidth);
    bw = segment_simple_threshold( revised_Ct );
    %% show results
    p = strcat('Image-0',num2str(index));
    subplot(3, length(files), index), imshow(I), title(p);
    if index==1
        ylabel('Original Images');
    end
    subplot(3, length(files), length(files)+index), imshow(mat2gray(revised_Ct));
    if index==1
        ylabel('Certainty Maps');
    end
    subplot(3, length(files), 2*length(files)+index), imshow(bw) ;
    if index==1
        ylabel('Sementation Results');
    end
    %% save into files
    imwrite(mat2gray(revised_Ct), [strSaveDir 'certainty/' files{index}]);
    imwrite(bw, [strSaveDir 'segmentation/' files{index}]);
end
saveas(gcf, 'doc/result.png');

