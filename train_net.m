%% train_net.m
%MAT 128b Project 2
%function to train neural net

function W = train_net(layers, neurons_input, neurons_hidden, neurons_output, trainingRate)

    % Initialize OUT function and weight matrix
    F = @(NET) 1./(1+exp(-NET));
    F_prime = @(NET) exp(-NET)./((1 + exp(-NET)).^2);

    W{1} = rand(neurons_input, neurons_hidden); %INPUT -> HIDDEN
    for i = 1:layers-1
        W{i+1} = rand(neurons_hidden, neurons_hidden); %HIDDEN -> HIDDEN
    end
    W{end+1} = rand(neurons_hidden, neurons_output); %HIDDEN -> OUTPUT
    
    
    for digit = 0:9
        TARGET = zeros(1,neurons_output);
        for i = 1:neurons_output
            if i-1 == digit
                TARGET(i) = 1;
            end
        end
        INPUT = double(logical(getMNIST(digit, 1)));
        
        for i = 1:max(size(INPUT))
            OUT_ = INPUT(i,:);
            OUT_input = OUT_;
            for j = 1:layers+1
                NET = OUT_*W{j};
                OUT_ = F(NET);
                OUT{j} = OUT_;
            end
            ERROR = abs(TARGET - OUT{end});
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
    end
end