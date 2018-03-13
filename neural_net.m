%% neural_net.m
%MAT 128b Project 2
%Create neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 3;               %select handwritten digit [0,9]
trainORtest = 1;         %boolean, 1 -> train, 0 -> test

%% Initialize INPUT data, OUT function and weight matrix
INPUT = double(logical(getMNIST(digit, trainORtest)));
F = @(NET) 1./(1+exp(-NET));
W = getWeight(digit);
layers = length(W) - 1;

%% Peform forward pass on input and display results
for i = 1:max(size(INPUT))
    
    %Forward Pass on all layers
    OUT = INPUT(i,:);
    for j = 1:layers+1
        NET = OUT*W{j};
        OUT = F(NET);
    end
    
    [~,d] = max(OUT);
    d = d - 1;
    
    disp(['Test #' num2str(i) ', Guess digit = ' num2str(d)])
    
end
disp(['Input digit = ' num2str(digit)])