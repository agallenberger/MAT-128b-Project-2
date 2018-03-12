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
%       - The HIDDEN-HIDDEN matrix will be empty unless 'layers > 1'

W_input = rand(neurons_input, neurons_hidden);
W_hidden = rand(neurons_hidden, neurons_hidden, layers-1);
W_output = rand(neurons_hidden, neurons_output);
for i = 1:neurons_hidden
    W_input(:,i) = W_input(:,i)./sum(W_input(:,i));
    for j = 1:layers-1
        W_hidden(:,i,j) = W_hidden(:,i,j)./sum(W_hidden(:,i,j));
        disp('x')
    end
end
for i = 1:neurons_output
   W_output(:,i) =  W_output(:,i)./sum(W_output(:,i));
end

%% Train the neural net on the desired digit
for i = 1:max(size(INPUT))
    
    %Case for no HIDDEN layers
    if layers == 0
        %INPUT to OUTPUT
        NET = INPUT(i,:)*W_input;
        OUT = F(NET);
        
        ERROR = abs(TARGET - OUT);
        deltaQK = OUT.*(1 - OUT).*ERROR;
        
        
    %Case for 1 HIDDEN layer
    elseif layers == 1
        %INPUT to HIDDEN
        NET = INPUT(i,:)*W_input;
        OUT = F(NET);
        
        %HIDDEN to OUTPUT
        NET = OUT*W_output;
        OUT = F(NET);
        
        ERROR = abs(TARGET - OUT);
        deltaQK = OUT.*(1 - OUT).*ERROR;
        
        
    %More than 1 HIDDEN layer
    else
        %INPUT to OUTPUT
        NET = INPUT(i,:)*W_input;
        OUT = F(NET);
        
        %HIDDEN to HIDDEN
        for j = 1:layer-1
            NET = OUT*W_hidden(:,:,j);
            OUT = F(NET);
        end
        
        %HIDDEN to OUTPUT
        NET = OUT*W_output;
        OUT = F(NET);
        
        ERROR = abs(TARGET - OUT);
        deltaQK = OUT.*(1 - OUT).*ERROR;
        
    end
    
end

%% Save weight matrices in .mat files
filename = ['W_' num2str(digit) '.mat'];
save(filename, 'W_input', 'W_hidden', 'W_output')

disp('--------------- TRAINING COMPLETE ---------------')
disp('Neural Net Parameters:')
disp(['  - Digit =                              ' num2str(digit)])
disp(['  - Number of HIDDEN layers =            ' num2str(layers)])
disp(['  - Number of INPUT neurons =            ' num2str(neurons_input)])
disp(['  - Number of HIDDEN neurons/layer =     ' num2str(neurons_hidden)])
disp(['  - Number of OUTPUT neurons =           ' num2str(neurons_output)])
disp(['  - Weight data written to:              ' filename])

