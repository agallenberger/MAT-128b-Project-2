%% neural_net.m
%MAT 128b Project 2
%Create neural net & test it
clear; clc; close all;
load W_master;

%% Test the Neural Net
F = @(NET) 1./(1+exp(-NET));
layers = length(W)-1;

[neurons_input, neurons_hidden] = size(W{1});
[~, neurons_output] = size(W{end});
disp(' Neural Net Parameters:')
disp(['   - Number of HIDDEN layers =            ' num2str(layers)])
disp(['   - Number of INPUT neurons =            ' num2str(neurons_input)])
disp(['   - Number of HIDDEN neurons/layer =     ' num2str(neurons_hidden)])
disp(['   - Number of OUTPUT neurons =           ' num2str(neurons_output)])
disp(['   - Training rate =                      ' num2str(trainingRate)])
disp(['   - Number of training images used =     ' num2str(inputSize)])
fprintf(' \nTesting....\n');

for digit = 0:9
    %Initialize testing variables
    INPUT = double(logical(getMNIST(digit, 0)));
    [iterations,~] = size(INPUT);
    pass = 0;
    TARGET = zeros(1,10);
    for k = 1:10
        if k-1 == digit
            TARGET(k) = 1;
        end
    end
    
    % Peform forward pass on input and display results
    for iter = 1:iterations
        X = INPUT(iter,:);
        for i = 1:layers+1
            NET = X*W{i};
            X = F(NET);
        end
        
        ERROR{digit+1}(iter,:) = TARGET - X;
        [maxOUT, digitOUT] = max(X);
        
        if digitOUT-1 == digit
            pass = pass+1;
        end
    end
    fprintf('   Digit = %1.0f, -> %2.1f%% success rate\n', digit, 100*pass/iterations);
end

fprintf(' \nAnalyze Error:\n')
for digit = 0:9
    for i = 1:10
        ERROR_avg(digit+1,i) = abs(mean(ERROR{digit+1}(:,i)));
    end
end
disp(ERROR_avg)
