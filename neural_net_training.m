%% neural_net_training.m
%MAT 128b Project 2 - Part 4, 5, 6
%Train the neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 1;               %select handwritten digit [0,9]
trainORtest = 1;         %boolean, 1 -> train, 0 -> test
layers = 2;              %number of hidden layers [1,inf)
neurons_hidden = 10;      %number of neurons per hidden layer
trainingRate = .1;       %within the interval [0.1, 0.01]

%Things you can't change
neurons_input = 784;     %number of neurons in the input layer
neurons_output = 10;     %number of neurons in the output layer

%% Load INPUT and TARGET data
%TARGET = de2bi(digit, neurons_output);
TARGET = zeros(1,neurons_output);
for iter = 1:neurons_output
    if iter-1 == digit
        TARGET(iter) = 1;
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

W{1} = (rand(neurons_input, neurons_hidden)*2 - 1)/10; %INPUT -> HIDDEN
for iter = 1:layers-1
    W{iter+1} = (rand(neurons_hidden, neurons_hidden)*2 - 1)/10; %HIDDEN -> HIDDEN
end
W{end+1} = (rand(neurons_hidden, neurons_output)*2 - 1)/10; %HIDDEN -> OUTPUT

%% Train the neural net on the desired digit
for iter = 1:max(size(INPUT))
    %Number of total computing layers = layers + 1
    %Number of weight matrices = layers + 1
    %Number of outputs = layers + 2
    
    %Forward Pass on all layers
    X = INPUT(iter,:);
    OUT{1} = X;
    for i = 1:layers+1
        NET = X*W{i};
        X = F(NET);
        OUT{i+1} = X;
        %weight W{i} of layer(i) produces output OUT{i+1}
    end
    
    %Calculate ERROR and delta at the OUTPUT layer
    ERROR = TARGET - OUT{end};
    delta{length(W)} = OUT{end}.*(1 - OUT{end}).*ERROR;
    
    %Reverse propagation
    [neurons_j, neurons_k] = size(W{end});
    for j = 1:neurons_j
        for k = 1:neurons_k
            w_change{length(W)}(j,k) = trainingRate*delta{end}(k)*OUT{end-1}(j);
        end
    end
    
    for numLayer = length(W)-1:-1:1
        delta{numLayer} = (delta{numLayer+1}*W{numLayer+1}').*(OUT{numLayer+1}.*(1 - OUT{numLayer+1}));
    end
    
%     for j = length(W)-1:-1:1
%         [neurons_j, neurons_k] = size(W{j+1});
%         for p = 1:neurons_j
%             sumK = 0;
%             for q = 1:neurons_k
%                 sumK = sumK + delta{j+1}(q)*W{j+1}(p,q);
%             end
%             delta{j}(p) = OUT{j}(p)*(1 - OUT{j}(p))*sumK;
%         end
%     end
    
    for numLayer = 1:length(W)-1
        [neurons_j, neurons_k] = size(W{numLayer});
        for j = 1:neurons_j
            for k = 1:neurons_k
                w_change{numLayer}(j,k) = trainingRate*delta{numLayer}(k)*OUT{numLayer}(j);
            end
        end
    end
    
    for i = 1:length(W)
        W{i} = W{i} + w_change{i};
    end

%     %Reverse pass from https://sudeepraja.github.io/Neural/  
%     delta{length(W)} = (OUT{end}' - TARGET').*ERROR';
%     for j = length(W)-1:-1:1
%         if j-1 == 0
%             delta{j} = (W{j+1}*delta{j+1}).*F_prime(W{j}'*OUT_input'); 
%         else
%             delta{j} = (W{j+1}*delta{j+1}).*F_prime(W{j}'*OUT{j-1}'); 
%         end
%     end
%     for j = 1:length(W)
%         if j-1 == 0
%             W{j} = W{j} - trainingRate.*W{j}.*(OUT_input'*delta{j}');
%         else
%             W{j} = W{j} - trainingRate.*W{j}.*(OUT{j-1}'*delta{j}');
%         end
%     end
    if mod(iter,100) == 0;
        disp([ num2str(iter) '/' num2str(max(size(INPUT)))])
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

