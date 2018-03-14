%% neural_net.m
%MAT 128b Project 2
%Create neural net
clear; clc; close all;
load W_master;

%% Test the Neural Net
F = @(NET) 1./(1+exp(-NET));
layers = length(W)-1;

[neurons_input, neurons_hidden] = size(W{1});
[~, neurons_output] = size(W{end});
disp('Neural Net Parameters:')
disp(['  - Number of HIDDEN layers =            ' num2str(layers)])
disp(['  - Number of INPUT neurons =            ' num2str(neurons_input)])
disp(['  - Number of HIDDEN neurons/layer =     ' num2str(neurons_hidden)])
disp(['  - Number of OUTPUT neurons =           ' num2str(neurons_output)])
disp('Testing....');

for digit = 0:9
    
    INPUT = double(logical(getMNIST(digit, 0)));
    [iterations,~] = size(INPUT);
    pass = 0;

    % Peform forward pass on input and display results
    for iter = 1:iterations
        X = INPUT(iter,:);
        OUT{1} = X;
        for i = 1:layers+1
            NET = X*W{i};
            X = F(NET);
            OUT{i+1} = X;
        end
        
        OUTPUT(iter,:) = X;
        [maxOUT, digitOUT] = max(X);
        
        if digitOUT-1 == digit
            pass = pass+1;
        end
    end
    
    OUTPUT;
    fprintf('  Digit = %1.0f, -> %2.1f%% success rate\n', digit, 100*pass/iterations);
    
end

