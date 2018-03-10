%% neuron.m
%MAT 128b Project 2
%neuron function

function OUT = neuron(input, weight)

    n = length(input);

    for i = 1:n
        NET = NET + input(i)*weight(i);    
    end

    OUT = (1+(e^(-NET)))^-1;

end