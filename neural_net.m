%% neural_net.m
%MAT 128b Project 2
%Create neural net
clear; clc; close all;
load mnistdata;
load W_master;

%% Initialize neural net parameters
digit = 4;               %select handwritten digit [0,9]
trainORtest = 0;         %boolean, 1 -> train, 0 -> test

%% Initialize INPUT data and OUT function
F = @(NET) 1./(1+exp(-NET));
INPUT = double(logical(getMNIST(digit, trainORtest)));

%% Peform forward pass on input and display results
%W = getWeight(z);

layers = length(W) - 1;
[iterations,~] = size(INPUT);
for i = 1:iterations

    %Forward Pass on all layers
    OUT = INPUT(i,:);
    OUT_{1} = OUT;
    for j = 1:layers+1
        NET = OUT*W{j};
        OUT = F(NET);
        OUT_{j+1} = OUT;
    end
    OUTPUT(i,:) = OUT;
    maxOUT(i) = max(OUT);
end


for i = 1:max(size(INPUT))
    [~,d] = max(maxOUT);
    d = d-1;
    %disp(['Test #' num2str(i) ', guess = ' num2str(d)])
end
%disp(['Expected Digit = ' num2str(digit)])
OUTPUT