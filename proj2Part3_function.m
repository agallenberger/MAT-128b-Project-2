function OUT = proj2Part3_function(input, weight)

    n = length(input);

    for i = 1:n
        NET = NET + input(i)*weight(i);    
    end

    OUT = (1+(e^(-NET)))^-1;

end