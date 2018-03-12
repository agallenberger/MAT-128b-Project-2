%% neural_net_training.m
%MAT 128b Project 2 - Part 4, 5, 6
%Train the neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;               %select handwritten digit [0,9]
trainORtest = 1;         %boolean, 1 -> train, 0 -> test
layers = 1;              %number of hidden layers
neurons_input = 784;     %number of neurons in the input layer
neurons_hidden = 784;    %number of neurons per hidden layer
neurons_output = 784;    %number of neurons in the output layer
trainingRate = .05;      %within the interval [0.1, 0.01]

%% Load INPUT and TARGET data
TARGET = getTARGET(digit);
INPUT = double(logical(getMNIST(digit, trainORtest)));
n = length(INPUT(1,:));

%% Initialize OUT function and weight matrix
F = @(NET) 1./(1+exp(-NET));

%Part 5 - Weight matrix for INPUT-HIDDEN, HIDDEN-HIDDEN, and HIDDEN-OUTPUT
%       - There will only be 1 INPUT-HIDDEN and HIDDEN-OUTPUT matrix, but multiple 
%         HIDDEN-HIDDEN matrices depending on the number of hidden layers
%       - Each column sums to 1
%       - W(i,j) is the weight from neuron_i to neuron_j
W_input = rand(neurons_input, neurons_hidden);
W_hidden = rand(neurons_hidden, neurons_hidden, layers);
W_output = rand(neurons_hidden, neurons_output);
for i = 1:neurons_hidden
    W_input(:,i) = W_input(:,i)./sum(W_input(:,i));
    for j = 1:layers
        W_hidden(:,i,j) = W_hidden(:,i,j)./sum(W_hidden(:,i,j));
    end
end
for i = 1:neurons_output
   W_output(:,i) =  W_output(:,i)./sum(W_output(:,i));
end

%% Train the neural net on the desired digit
for i = 1:max(size(INPUT))
 
%     FIX THIS
%
%     %--------------------------------%
%     OUT = INPUT(i,:);                % INPUT Layer
%     %--------------------------------%
%     
%     %--------------------------------%
%     for j = 1:layers                 %
%         NET = OUT*W_input;                 % HIDDEN Layers
%         OUT = F(NET);                %
%     end                              %
%     %--------------------------------%
%     
%     %----------------------------------------------%
%     ERROR = abs(TARGET - OUT);       % OUTPUT Layer
%     deltaQK = OUT.*(1 - OUT).*ERROR;               %
%     %----------------------------------------------%
%     
%     %Reverse pass error propagation
%     for j = layers:-1:1 %loop through layers backwards
%         for k = 1:n %loop through each neruon in the layer
%             %W(j,k) = ...
%         end
%     end
    
end

%% Save weight matrices in .mat files
filename = ['W_' num2str(digit) '.mat'];
save(filename, 'W_input', 'W_hidden', 'W_output')

disp(['Training complete, weight data written to ' filename])







