%% neural_net.m
%MAT 128b Project 2
%Load MNIST data of handwritten digits
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;
train = 1; %if 0, will use test digit instead
layers = 1; %number of hidden layers

%% Load INPUT and TARGET data
T(1,:) = mean(train0); 
T(2,:) = mean(train1); 
T(3,:) = mean(train2); 
T(4,:) = mean(train3); 
T(5,:) = mean(train4); 
T(6,:) = mean(train5); 
T(7,:) = mean(train6); 
T(8,:) = mean(train7); 
T(9,:) = mean(train8); 
T(10,:) = mean(train9);
input = double(logical(getMNISTdata(digit,train)));
n = length(input(1,:));

%% Create neural network using neuron.m
%Part 5 - initialize weight matrix. Each row sums to 1.
W = rand(n,n);
for i = 1:n
    W(i,:) = W(i,:)./sum(W(i,:));
end

%Train neural net on each digit
OUT = zeros(n,1);
ERROR = zeros(n,1);
for j = 1:layers
    for i = 1:n
        OUT(i) = neuron(input(1,:), W(i,:));
    end
    fprintf('digit %1.0f, pass #%1.0f -> average OUT = %1.7f\n', digit, j, mean(OUT)); 
end
