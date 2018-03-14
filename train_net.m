%% train_net.m
%MAT 128b Project 2
%function to train neural net

function W = train_net(INPUT, digits, W, layers, trainingRate)

    F = @(NET) 1./(1+exp(-NET));
    [iterations,~] = size(INPUT);
    
    for iter = 1:iterations
        
        %Get target vector
        TARGET = zeros(1,10);
        for k = 1:length(TARGET)
            if k-1 == digits(iter)
                TARGET(k) = 1;
            end
        end
        
        %---Forward Pass on all layers---
        X = INPUT(iter,:);
        OUT{1} = X;
        for i = 1:layers+1
            NET = X*W{i};
            X = F(NET);
            OUT{i+1} = X;
            %weight W{i} of layer(i) produces output OUT{i+1}
        end
        
        %---Reverse Propagation---
        %Calculate ERROR, delta, and w_change at the OUTPUT layer
        ERROR = TARGET - OUT{end};
        delta{length(W)} = OUT{end}.*(1 - OUT{end}).*ERROR;
        w_change = trainingRate.*(delta{end}'*OUT{end-1})';
        
        %Get delta for all other layers
        for numLayer = length(W)-1:-1:1
            delta{numLayer} = (delta{numLayer+1}*W{numLayer+1}').*(OUT{numLayer+1}.*(1 - OUT{numLayer+1}));
        end
        
        %Get w_change & apply changes
        for numLayer = 1:length(W)-1
            W{numLayer} = W{numLayer} + trainingRate.*(delta{numLayer}'*OUT{numLayer})';
        end
        W{end} = W{end} + w_change;

        
        %Output training progress
        if mod(iter,500) == 0
            clc;
            disp('Progress (images trained):');
            fprintf('%1.0f/%1.0f \n', iter, iterations);
        end

    end
        
end