%% neural_net_training.m
%MAT 128b Project 2 - Part 4, 5, 6
%Train the neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 1;               %select handwritten digit [0,9]
trainORtest = 1;         %boolean, 1 -> train, 0 -> test
layers = 1;              %number of hidden layers [1,inf)
neurons_hidden = 30;      %number of neurons per hidden layer
trainingRate = .1;       %within the interval [0.1, 0.01]

%Things you can't change
neurons_input = 784;     %number of neurons in the input layer
neurons_output = 10;     %number of neurons in the output layer

%% Load INPUT and TARGET data
%TARGET = de2bi(digit, neurons_output).*100;
TARGET = zeros(1,neurons_output);
for i = 1:neurons_output
    if i-1 == digit
        TARGET(i) = 100;
    end
end
INPUT = double(logical(getMNIST(digit, trainORtest)));

%% Initialize OUT function and weight matrix
F = @(NET) 1./(1+exp(-NET));
F_prime = @(NET) exp(-NET)./((1 + exp(-NET)).^2);

%Part 5 - Weight matrix for INPUT-HIDDEN, HIDDEN-HIDDEN, and HIDDEN-OUTPUT
%       - There will only be 1 INPUT-HIDDEN and HIDDEN-OUTPUT matrix, but multiple 
%         HIDDEN-HIDDEN matrices depending on the number of hidden layers
%       - W(i,j) is the weight from neuron_i to neuron_j

W{1} = rand(neurons_input, neurons_hidden); %INPUT -> HIDDEN
for i = 1:layers-1
    W{i+1} = rand(neurons_hidden, neurons_hidden); %HIDDEN -> HIDDEN
end
W{end+1} = rand(neurons_hidden, neurons_output); %HIDDEN -> OUTPUT

%% Train the neural net on the desired digit
for i = 1:max(size(INPUT))
    
    %Forward Pass on all layers
    OUT_ = INPUT(i,:);
    OUT_input = OUT_;
    for j = 1:layers+1
        NET = OUT_*W{j};
        OUT_ = F(NET);
        OUT{j} = OUT_;
    end
    
    %Calculate ERROR and delta at the OUTPUT layer
    ERROR = abs(TARGET - OUT{end});

    %Reverse pass from https://sudeepraja.github.io/Neural/  
    delta{length(W)} = (OUT{end}' - TARGET').*ERROR';
    for j = length(W)-1:-1:1
        if j-1 == 0
            delta{j} = (W{j+1}*delta{j+1}).*F_prime(W{j}'*OUT_input'); 
        else
            delta{j} = (W{j+1}*delta{j+1}).*F_prime(W{j}'*OUT{j-1}'); 
        end
    end
    for j = 1:length(W)
        if j-1 == 0
            W{j} = W{j} - trainingRate.*W{j}.*(OUT_input'*delta{j}');
        else
            W{j} = W{j} - trainingRate.*W{j}.*(OUT{j-1}'*delta{j}');
        end
    end
    
end

%% Save weight matrices in .mat files
filename = 'W.mat';
save(filename, 'W')

disp('--------------- TRAINING COMPLETE ---------------')
disp('Neural Net Parameters:')
disp(['  - Digit =                              ' num2str(digit)])
disp(['  - Number of HIDDEN layers =            ' num2str(layers)])
disp(['  - Number of INPUT neurons =            ' num2str(neurons_input)])
disp(['  - Number of HIDDEN neurons/layer =     ' num2str(neurons_hidden)])
disp(['  - Number of OUTPUT neurons =           ' num2str(neurons_output)])
disp(['  - Weight data written to:              ' filename])

