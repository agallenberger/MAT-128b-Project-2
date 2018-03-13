%% train_net_main.m
%MAT 128b Project 2 - Part 4, 5, 6
%Driver file for train_net.m
clear; clc; close all;

%% Initialize neural net parameters
layers = 2;              %number of hidden layers [1,inf)
neurons_hidden = 10;      %number of neurons per hidden layer
trainingRate = .1;       %within the interval [0.1, 0.01]

%Things you can't change
neurons_input = 784;     %number of neurons in the input layer
neurons_output = 10;     %number of neurons in the output layer

%% Train the neural net using train_net.m
W{1} = rand(neurons_input, neurons_hidden); %INPUT -> HIDDEN
for i = 1:layers-1
    W{i+1} = rand(neurons_hidden, neurons_hidden); %HIDDEN -> HIDDEN
end
W{end+1} = rand(neurons_hidden, neurons_output); %HIDDEN -> OUTPUT

for i = 1:100
    for digit = 0:9
        INPUT = double(logical(getMNIST(digit, 1)));
        W = train_net(INPUT(i,:), W, layers, neurons_output, trainingRate, digit);
    end
    if mod(i,100) == 0
            disp([ num2str(i/100) '/20'])
    end
end

%% Save weight matrices in .mat files
filename = 'W_master.mat';
save(filename, 'W')

disp('--------------- TRAINING COMPLETE ---------------')
disp('Neural Net Parameters:')
disp(['  - Number of HIDDEN layers =            ' num2str(layers)])
disp(['  - Number of INPUT neurons =            ' num2str(neurons_input)])
disp(['  - Number of HIDDEN neurons/layer =     ' num2str(neurons_hidden)])
disp(['  - Number of OUTPUT neurons =           ' num2str(neurons_output)])
disp(['  - Weight data written to:              ' filename])