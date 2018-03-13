%% neural_net.m
%MAT 128b Project 2
%Create neural net
clear; clc; close all;
load mnistdata;
%load W_master;

%% Initialize neural net parameters
digit = 2;               %select handwritten digit [0,9]
trainORtest = 0;         %boolean, 1 -> train, 0 -> test

%% Initialize INPUT data and OUT function
F = @(NET) 1./(1+exp(-NET));
INPUT = double(logical(getMNIST(digit, trainORtest)));

%% Peform forward pass on input and display results
for z = 0:9
    W = getWeight(z);
    layers = length(W) - 1;
    for i = 1:max(size(INPUT))

        %Forward Pass on all layers
        OUT = INPUT(i,:);
        for j = 1:layers+1
            NET = OUT*W{j};
            OUT = F(NET);
        end
        maxOUT{z+1}(i) = max(OUT);
    end
end

for i = 1:max(size(INPUT))
    output = zeros(1,10);
    for k = 1:10
        output(k) = maxOUT{k}(i);
    end
    [~,d] = max(output);
    d = d-1;
    disp(['Test #' num2str(i) ', guess = ' num2str(d)])
end 
disp(['Test Digit = ' num2str(digit)])
output