%% train_net.m
%MAT 128b Project 2
%function to train neural net

function W = train_net(INPUT, digits, W, layers, trainingRate)

    F = @(NET) 1./(1+exp(-NET));
    
    [iterations,~] = size(INPUT);
    for iter = 1:iterations
        
        %Get target vector
        TARGET = zeros(1,10);
        for k = 1:10
            if k-1 == digits(iter)
                TARGET(k) = 1;
            end
        end
        
        %Forward Pass on all layers
        X = INPUT(iter,:);
        OUT{1} = X;
        for i = 1:layers+1
            NET = X*W{i};
            X = F(NET);
            OUT{i+1} = X;
            %weight W{i} of layer(i) produces output OUT{i+1}
        end

        %Calculate ERROR and delta at the OUTPUT layer
        ERROR = TARGET - OUT{end};
        delta{length(W)} = OUT{end}.*(1 - OUT{end}).*ERROR;

        %Reverse propagation
        [neurons_j, neurons_k] = size(W{end});
        for j = 1:neurons_j
            for k = 1:neurons_k
                w_change{length(W)}(j,k) = trainingRate*delta{end}(k)*OUT{end-1}(j);
            end
        end

%         for numLayer = length(W)-1:-1:1
%             delta{numLayer} = (delta{numLayer+1}*W{numLayer+1}').*(OUT{numLayer+1}.*(1 - OUT{numLayer+1}));
%         end

        for j = length(W)-1:-1:1
            [neurons_j, neurons_k] = size(W{j+1});
            for p = 1:neurons_j
                sumK = 0;
                for q = 1:neurons_k
                    sumK = sumK + delta{j+1}(q)*W{j+1}(p,q);
                end
                delta{j}(p) = OUT{j}(p)*(1 - OUT{j}(p))*sumK;
            end
        end

        for numLayer = 1:length(W)-1
            [neurons_j, neurons_k] = size(W{numLayer});
            for j = 1:neurons_j
                for k = 1:neurons_k
                    w_change{numLayer}(j,k) = trainingRate*delta{numLayer}(k)*OUT{numLayer}(j);
                end
            end
        end

        for i = 1:length(W)
            W{i} = W{i} + w_change{i};
        end
        
        %Output training progress
        if mod(iter,500) == 0
            clc;
            disp('Progress (images trained):');
            fprintf('%1.0f/%1.0f \n', iter, iterations);
        end

    end
        
end