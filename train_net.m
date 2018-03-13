%% train_net.m
%MAT 128b Project 2
%function to train neural net

function W = train_net(INPUT, W, layers, neurons_output, trainingRate, digit)

    F = @(NET) 1./(1+exp(-NET));
    F_prime = @(NET) exp(-NET)./((1 + exp(-NET)).^2);
    
    TARGET = zeros(1,neurons_output);
    for i = 1:neurons_output
        if i-1 == digit
            TARGET(i) = 1;
        end
    end

    OUT_ = INPUT;
    OUT_input = OUT_;
    for j = 1:layers+1
        NET = OUT_*W{j};
        OUT_ = F(NET);
        OUT{j} = OUT_;
    end
    delta{length(W)} = (OUT{end}' - TARGET').*F_prime(W{end}'*OUT{end-1}');
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
end