%% neural_net.m
%MAT 128b Project 2
%Load MNIST data of handwritten digits
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;
train = 1; %if 0, will use test digit instead
layers = 1; %number of hidden layers

%% Create neural network using neuron.m
input = double(logical(getMNISTdata(digit,train)));
n = length(input(1,:));

%Part 5 - initialize weight matrix. Each row sums to 1.
W = rand(n,n);
for i = 1:n
    W(i,:) = W(i,:)./sum(W(i,:));
end

%Train neural net on each digit
OUT = zeros(n,1);
for j = 1:layers
    for i = 1:n
        OUT(i) = neuron(input(1,:), W(i,:));
    end
    fprintf('digit %1.0f, pass #%1.0f -> average OUT = %1.7f\n', digit, j, mean(OUT));    
end
