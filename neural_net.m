%% neural_net.m
%MAT 128b Project 2
%Load MNIST data of handwritten digits
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
train = 1; %if 0, will use test digit instead
layers = 1; %number of hidden layers

%% Create neural network using neuron.m
n = length(train0(1,:));

%Part 5 - initialize weight matrix. Each row sums to 1.
W = rand(n,n);
for i = 1:n
    W(i,:) = W(i,:)./sum(W(i,:));
end

for k = 0:9
    input = double(logical(getMNISTdata(k,train)));
    OUT = zeros(n,1);
    for i = 1:n
        OUT(i) = neuron(input(1,:), W(i,:));
    end
    fprintf('digit %1.0f -> average OUT = %1.7f\n', k, mean(OUT));
end
