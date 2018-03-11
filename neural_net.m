%% neural_net.m
%MAT 128b Project 2
%Load MNIST data of handwritten digits
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;
train = 1; %if 0, will use test digit instead
layers = 1; %number of hidden layers

%% Load selected digit from mnistdata
if digit == 0
    if train == 1
        input = train0;
    else
        input = test0;
    end
elseif digit == 1
    if train == 1
        input = train1;
    else
        input = test1;
    end
elseif digit == 2
    if train == 1
        input = train2;
    else
        input = test2;
    end
 elseif digit == 3
    if train == 1
        input = train3;
    else
        input = test3;
    end
elseif digit == 4
    if train == 1
        input = train4;
    else
        input = test4;
    end
elseif digit == 5
    if train == 1
        input = train5;
    else
        input = test5;
    end
elseif digit == 6
    if train == 1
        input = train6;
    else
        input = test6;
    end
elseif digit == 7
    if train == 1
        input = train7;
    else
        input = test7;
    end
elseif digit == 8
    if train == 1
        input = train8;
    else
        input = test8;
    end    
elseif digit == 9
    if train == 1
        input = train9;
    else
        input = test9;
    end
end

%% Create neural network using neuron.m
input = double(input);
n = length(input(1,:)); %Length of each digit sample
W = rand(n,n);
OUT = zeros(n,1);

for i = 1:n
    W(i,:) = W(i,:)./sum(W(i,:));
end


for i = 1:n;
    
    OUT(i) = neuron(input(1,:), W(i,:));
    
    
    
    
end
image(reshape(OUT,28,28))

