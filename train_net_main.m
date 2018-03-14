%% train_net_main.m
%MAT 128b Project 2 - Part 4, 5, 6
%Driver file for train_net.m
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
layers = 3;               %number of hidden layers [1,inf)
neurons_hidden = 40;      %number of neurons per hidden layer
trainingRate = .03;        %within the interval [0.01, 0.1]
inputSize = 500000;        %number of digit image samples in the input

%Things you can't change
neurons_input = 784;      %number of neurons in the input layer
neurons_output = 10;      %number of neurons in the output layer

%% Initialize weight matrices
W{1} = (rand(neurons_input, neurons_hidden)*2-1)/10; %INPUT -> HIDDEN
for iter = 1:layers-1
    W{iter+1} = (rand(neurons_hidden, neurons_hidden)*2-1)/10; %HIDDEN -> HIDDEN
end
W{end+1} = (rand(neurons_hidden, neurons_output)*2-1)/10; %HIDDEN -> OUTPUT

%% Load training data
train{1} = train0;
train{2} = train1;
train{3} = train2;
train{4} = train3;
train{5} = train4;
train{6} = train5;
train{7} = train6;
train{8} = train7;
train{9} = train8;
train{10} = train9;

%% Initialize the input and train the neural net
disp('Initializing...');
INPUT = zeros(inputSize, 784);
digits = [0 1 2 3 4 5 6 7 8 9];
digits = repmat(digits,1,inputSize/10);
for i = 1:inputSize
    INPUT(i,:) = train{digits(i)+1}(ceil(rand()*5400),:);
end
W = train_net(INPUT, digits, W, layers, trainingRate);
clc;

%% Save weight matrices in .mat files
filename = 'W_master.mat';
save(filename, 'W', 'inputSize', 'trainingRate')

disp('--------------- TRAINING COMPLETE ---------------')
disp('Neural Net Parameters:')
disp(['  - Number of HIDDEN layers =            ' num2str(layers)])
disp(['  - Number of INPUT neurons =            ' num2str(neurons_input)])
disp(['  - Number of HIDDEN neurons/layer =     ' num2str(neurons_hidden)])
disp(['  - Number of OUTPUT neurons =           ' num2str(neurons_output)])
disp(['  - Training rate =                      ' num2str(trainingRate)])
disp(['  - Number of training images used =     ' num2str(inputSize)])
disp(['  - Weight data written to:              ' filename])