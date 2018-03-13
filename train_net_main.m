%% train_net_main.m
%MAT 128b Project 2 - Part 4, 5, 6
%Driver file for train_net.m
clear; clc; close all;

%% Initialize neural net parameters
layers = 2;              %number of hidden layers [1,inf)
neurons_hidden = 4;      %number of neurons per hidden layer
trainingRate = .05;       %within the interval [0.1, 0.01]

%Things you can't change
neurons_input = 784;     %number of neurons in the input layer
neurons_output = 10;     %number of neurons in the output layer

%% Train the neural net using train_net.m
W = train_net(layers, neurons_input, neurons_hidden, neurons_output, trainingRate);

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