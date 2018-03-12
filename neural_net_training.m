%% neural_net_training.m
%MAT 128b Project 2 - Part 4, 5, 6
%Train the neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;               %select handwritten digit [0,9]
trainORtest = 1;         %boolean, 1 -> train, 0 -> test
layers = 1;              %number of hidden layers [1,inf)
neurons_hidden = 4;      %number of neurons per hidden layer
trainingRate = .05;      %within the interval [0.1, 0.01]

%Things you can't change
neurons_input = 784;     %number of neurons in the input layer
neurons_output = 10;     %number of neurons in the output layer

%% Load INPUT and TARGET data
TARGET = zeros(1,neurons_output);
for i = 1:neurons_output
    if i-1 == digit
        TARGET(i) = 1;
    end
end
INPUT = double(logical(getMNIST(digit, trainORtest)));

%% Initialize OUT function and weight matrix
F = @(NET) 1./(1+exp(-NET));

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
    
    %Forward Pass
    OUT = INPUT(i,:);
    for j = 1:layers+1
        NET = OUT*W{j};
        OUT = F(NET);
        OUT_data{j} = OUT;
    end
    
    %Calculate error at the OUTPUT layer
    ERROR = abs(TARGET - OUT_data{end});
    D_output = OUT_data{end}.*(ones(size(OUT_data{end})) - OUT_data{end}).*ERROR;


    %Reverse Pass on HIDDEN -> OUTPUT weights
    w_change_output = zeros(neurons_hidden, neurons_output);
    for k = 1:neurons_hidden
        for j = 1:neurons_output
            w_change_output(k,j) = trainingRate*D_output(j)*OUT_data{end}(k);
        end
    end
    W{end} = W{end} + w_change_output;


    %Reverse Pass on HIDDEN -> HIDDEN weights
    w_change_hidden = zeros(neurons_hidden, neurons_hidden);

    

    if mod(i,100) == 0
        fprintf('Pass #%1.0f, avg error = %1.7f\n', i, mean(ERROR))
    end
    
end

%% Save weight matrices in .mat files
filename = ['W_' num2str(digit) '.mat'];
save(filename, 'W')

disp('--------------- TRAINING COMPLETE ---------------')
disp('Neural Net Parameters:')
disp(['  - Digit =                              ' num2str(digit)])
disp(['  - Number of HIDDEN layers =            ' num2str(layers)])
disp(['  - Number of INPUT neurons =            ' num2str(neurons_input)])
disp(['  - Number of HIDDEN neurons/layer =     ' num2str(neurons_hidden)])
disp(['  - Number of OUTPUT neurons =           ' num2str(neurons_output)])
disp(['  - Weight data written to:              ' filename])

