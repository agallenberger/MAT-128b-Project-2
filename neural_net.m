%% neural_net.m
%MAT 128b Project 2
%Create neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
trainORtest = 1;         %boolean, 1 -> train, 0 -> test

%Initialize OUT function 
F = @(NET) 1./(1+exp(-NET));

%% Peform forward pass on input and display results
for digit = 0:9
    
    %Initialize inputs, weights, and layers for the digit
    INPUT = double(logical(getMNIST(digit, trainORtest)));
    W = getWeight(digit);
    layers = length(W) - 1;
    
    fprintf('Testing');
    fail = 0;
    for i = 1:max(size(INPUT))

        %Forward Pass on all layers
        OUT = INPUT(i,:);
        for j = 1:layers+1
            NET = OUT*W{j};
            OUT = F(NET);
        end

        [~,d] = max(OUT);
        d = d - 1;


        if d ~= digit
            fprintf('\n')
            disp(['Test ' num2str(i) '/' num2str(max(size(INPUT))) ' failed.']) 
            disp(['Guess digit = ' num2str(d) ', Input digit = ' num2str(digit)])
            fail = 1;
            break;
        end
        if mod(i,100) == 0
            fprintf('.');
        end

    end
    if fail == 0
        fprintf('\n')
        disp([num2str(i) '/' num2str(max(size(INPUT))) ' tests passed'])
        disp(['Input digit = ' num2str(digit)])
    end
    fprintf('\n');
    
end

