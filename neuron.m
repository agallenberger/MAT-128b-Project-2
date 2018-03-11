%% neuron.m
%MAT 128b Project 2 - Part 3
%neuron function

function OUT = neuron(input, weight)

    NET = sum(input.*weight);
    OUT = 1./(1+(exp(-NET)));

end