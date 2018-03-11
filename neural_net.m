%% neural_net.m
%MAT 128b Project 2
%Create neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;
train = 1; %if 0, will use test digit instead
layers = 100; %number of hidden layers
trainingRate = .05; %within the interval [0.1, 0.01]

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
delta = zeros(n,1);
fprintf('Digit = %1.0f\n', digit);
for j = 1:layers
    for i = 1:n
        OUT(i) = neuron(input(j,:), W(i,:));
    end
    ERROR = abs(OUT - T(digit + 1, :)');
    delta = OUT.*(1-OUT).*ERROR;
    W(i,:) = trainingRate.*delta.*OUT;
    fprintf('  pass #%1.0f, avg ERROR = %1.7f\n', j, mean(ERROR));
    input = OUT';
end

%% Save weight matrix in CSV text file
filename = ['W_digit_' num2str(digit) '.txt'];
csvwrite(filename, W);
