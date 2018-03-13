%% neural_net.m
%MAT 128b Project 2
%Create neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 3;               %select handwritten digit [0,9]
trainORtest = 1;         %boolean, 1 -> train, 0 -> test
layers = 2;              %number of hidden layers [1,inf)
neurons_hidden = 3;      %number of neurons per hidden layer
trainingRate = .1;       %within the interval [0.1, 0.01]

%Things you can't change
neurons_input = 784;     %number of neurons in the input layer
neurons_output = 10;     %number of neurons in the output layer

%% Initialize INPUT data, OUT function and weight matrix
INPUT = double(logical(getMNIST(digit, trainORtest)));
F = @(NET) 1./(1+exp(-NET));
W = getWeight(digit);

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
    
    disp(['Input digit = ' num2str(digit) ', Guess digit = ' num2str(d)])
    
end
