%% neural_net2.m
%MAT 128b Project 2 - Part 4, 5, 6
%Train the neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;          %select handwritten digit [0,9]
train = 1;          %if 0, will use test digit instead
layers = 10;        %number of hidden layers
trainingRate = .05; %within the interval [0.1, 0.01]

%% Load INPUT and TARGET data
TARGET(1,:) = mean(train0); 
TARGET(2,:) = mean(train1); 
TARGET(3,:) = mean(train2); 
TARGET(4,:) = mean(train3); 
TARGET(5,:) = mean(train4); 
TARGET(6,:) = mean(train5); 
TARGET(7,:) = mean(train6); 
TARGET(8,:) = mean(train7); 
TARGET(9,:) = mean(train8); 
TARGET(10,:) = mean(train9);
INPUT = double(logical(getMNISTdata(digit,train)));
n = length(INPUT(1,:));

%% Initialize OUT function and weight matrix
F = @(NET) 1./(1+exp(-NET));
%NET = @(input, weight) sum(input.*weight);
W = rand(n,n);

%% Forward pass neural net
for i = 1:max(size(INPUT))
    %Get individual images from input data
    OUT = INPUT(i,:); 
    
    for j = 1:layers
        %Loop through every layer of the net, forward pass
        NET = OUT*W;
        
        
    end
    
end
