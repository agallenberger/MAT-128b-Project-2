%% neural_net_training.m
%MAT 128b Project 2 - Part 4, 5, 6
%Train the neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;               %select handwritten digit [0,9]
trainORtest = 1;         %boolean, 1 -> train, 0 -> test
layers = 2;              %number of hidden layers [1,inf)
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
    
    %Forward Pass on all layers
    OUT = INPUT(i,:);
    OUT_data{1} = OUT;
    for j = 1:layers+1
        NET = OUT*W{j};
        OUT = F(NET);
        OUT_data{j+1} = OUT;
    end
    
    %Calculate ERROR and delta at the OUTPUT layer
    ERROR = abs(TARGET - OUT_data{end});
    delta{length(W)} = OUT_data{end}.*(1 - OUT_data{end}).*ERROR;

    %Reverse Pass on HIDDEN -> OUTPUT weights
    for j = 1:length(OUT_data{end-1})
        for k = 1:length(OUT_data{end})
            w_change{length(W)}(j,k) = trainingRate*delta{length(W)}(k)*OUT_data{end-1}(j);
        end
    end

    %Reverse Pass on HIDDEN -> HIDDEN and INPUT -> HIDDEN weights
    for k = length(W):-1:2
        
        delta{k-1} = (delta{k}*W{end}').*(OUT_data{k}.*(1 - OUT_data{k}));
        
        for j = 1:length(OUT_data{k-1})
            for z = 1:length(OUT_data{k-1})
                
                w_change{k-1}(j,z) = trainingRate*delta{k-1}(z)*OUT_data{k-1}(j);
                disp(['k = ' num2str(k) ' to ' num2str(2)])
                disp(['j = ' num2str(j) ' to ' num2str(length(OUT_data{k-1}))])
                disp(['z = ' num2str(z) ' to ' num2str(length(OUT_data{k-1}))])
                disp(' ')
                
            end
        end
    end
    
    %Apply weight changes
    for j = 1:length(W)
        W{j} = W{j} + w_change{j};
    end

    %Display error at every 100 iterations
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

