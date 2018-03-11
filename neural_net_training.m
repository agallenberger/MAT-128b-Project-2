%% neural_net_training.m
%MAT 128b Project 2 - Part 4, 5, 6
%Train the neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;          %select handwritten digit [0,9]
train = 1;          %if 0, will use test digit instead
layers = 1;         %number of hidden layers [0,3]
trainingRate = .05; %within the interval [0.1, 0.01]

%% Load INPUT and TARGET data
TARGET = getTARGET(digit);
INPUT = double(logical(getMNIST(digit, train)));
n = length(INPUT(1,:));

%% Initialize OUT function and weight matrix
F = @(NET) 1./(1+exp(-NET));

%Part 5 - initialize weight matrix. Each row sums to 1.
W = rand(n,n);
for i = 1:n
    W(i,:) = W(i,:)./sum(W(i,:));
end

%% Train the neural net on the desired digit
for i = 1:max(size(INPUT))
    
    %--------------------------------%
    OUT = INPUT(i,:);                % INPUT Layer
    %--------------------------------%
    
    %--------------------------------%
    for j = 1:layers                 %
        NET = OUT*W;                 % HIDDEN Layers
        OUT = F(NET);                %
    end                              %
    %--------------------------------%
    
    %----------------------------------------------%
    ERROR = abs(TARGET - OUT);       % OUTPUT Layer
    deltaQK = OUT.*(1 - OUT).*ERROR;               %
    %----------------------------------------------%
    
    %Reverse pass error propagation
    for j = layers:-1:1 %loop through layers backwards
        for k = 1:n %loop through each neruon in the layer
            %W(j,k) = ...
        end
    end
    
end


%% Save weight matrix in CSV text file
filename = ['W_digit' num2str(digit) '.txt'];
csvwrite(filename, W);
disp(['Training complete, weight data written to ' 'W_digit' num2str(digit) '.txt'])

