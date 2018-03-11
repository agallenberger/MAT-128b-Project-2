%% neuron.m
%MAT 128b Project 2
%neuron function from part3.m

function OUT = neuron(input, weight)

    NET = sum(input.*weight);
    OUT = 1/(1+(exp(-NET)));

end