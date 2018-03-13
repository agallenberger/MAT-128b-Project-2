%% train_net.m
%MAT 128b Project 2
%function to train neural net

function W = train_net(INPUT, digits, W, layers, trainingRate)

    F = @(NET) 1./(1+exp(-NET));
    F_prime = @(NET) exp(-NET)./((1 + exp(-NET)).^2);
    
    [iterations,~] = size(INPUT);
    for i = 1:iterations
        TARGET = zeros(1,10);
        for k = 1:10
            if k-1 == digits(k)
                TARGET(k) = 1;
            end
        end
        
        OUT_ = INPUT(i,:);
        OUT_input = OUT_;
        for j = 1:layers+1
            NET = OUT_*W{j};
            OUT_ = F(NET);
            OUT{j} = OUT_;
        end
        ERROR = abs(TARGET - OUT{end});
        
        delta{length(W)} = (OUT{end}' - TARGET').*ERROR';
        for j = length(W)-1:-1:1
            if j-1 == 0
                delta{j} = (W{j+1}*delta{j+1}).*F_prime(W{j}'*OUT_input'); 
            else
                delta{j} = (W{j+1}*delta{j+1}).*F_prime(W{j}'*OUT{j-1}'); 
            end
        end
        for j = 1:length(W)
            if j-1 == 0
                W{j} = W{j} - trainingRate.*W{j}.*(OUT_input'*delta{j}');
            else
                W{j} = W{j} - trainingRate.*W{j}.*(OUT{j-1}'*delta{j}');
            end
        end
%         for k = 1:length(W)
%            [~, col] = size(W{k});
%            for j = 1:col
%                W{k}(:,j) = W{k}(:,j)/sum(W{k}(:,j));
%            end
%         end
    end
        
end