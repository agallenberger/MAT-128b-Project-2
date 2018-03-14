%% neural_net.m
%MAT 128b Project 2
%Create neural net
clear; clc; close all;
load mnistdata;
load W_master;

%% Initialize neural net parameters
digit = 0;               %select handwritten digit [0,9]

%% Initialize INPUT data and OUT function
F = @(NET) 1./(1+exp(-NET));
INPUT = double(logical(getMNIST(digit, 0)));
layers = length(W)-1;
[iterations,~] = size(INPUT);
pass = 0;

%% Peform forward pass on input and display results
for iter = 1:iterations
    %Forward Pass on all layers
    %Forward Pass on all layers
    X = INPUT(iter,:);
    OUT{1} = X;
    for i = 1:layers+1
        NET = X*W{i};
        X = F(NET);
        OUT{i+1} = X;
        %weight W{i} of layer(i) produces output OUT{i+1}
    end
    OUTPUT(iter,:) = X;
    [maxOUT, digitOUT] = max(X);
    if digitOUT-1 == digit
        pass = pass+1;
    end
end
OUTPUT
fprintf('    %2.1f%% success rate\n', 100*pass/iterations);